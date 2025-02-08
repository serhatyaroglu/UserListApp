//
//  UserListVC.swift
//  User List App
//
//  Created by serhat yaroglu on 7.02.2025.
//

import UIKit
import SnapKit

class UserListVC: UIViewController {
    let viewModel = ViewModel()

    
    private let tableView = UserTableView()

    let titleLabel: UILabel = {
          let label = UILabel()
          label.text = "User List App"
          label.font = .systemFont(ofSize: 24, weight: .bold)
          return label
      }()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
        
        viewModel.fetchUserList(for: .users)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        viewModel.delegate = self

        titleLabel.snp.makeConstraints { make in
            view.addSubview(titleLabel)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        tableView.userListDelegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            view.addSubview(tableView)

            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    //MARK: - burada tableview i refresh ediyoruz.
    private func setupRefreshControl() {
        DispatchQueue.main.async {
            LottieManager.showFullScreenLottie(animation: .loadingCircle2)
        }
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }
    //MARK: - refresh ettiğimizde bu fonksiyon çalışır
    @objc private func handlePullToRefresh() {
     
            DispatchQueue.main.async {
                LottieManager.showFullScreenLottie(animation: .loadingCircle2)
            }
        viewModel.fetchUserList(for: .users)
    }

    
}


extension UserListVC: ViewModelDelegate {
    //MARK: - data geldiğinde tableview güncellenir
    func userListDidFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            LottieManager.removeFullScreenLottie()
        }
    }
    //MARK: - error durumunda error tipine göre aşağıdaki alertler gösterilir
    func errorOccurred(error: NetworkError) {
        DispatchQueue.main.async {
            switch error {
            case .unableToCompleteError:
                AlertManager.present(title: "İstek Tamamlanamadı", message: "İsteğinizi tamamlayamadık. Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            case .invalidResponse:
                AlertManager.present(title: "Geçersiz Yanıt", message: "Sunucudan geçersiz bir yanıt aldık. Lütfen tekrar deneyin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            case .invalidData:
                AlertManager.present(title: "Geçersiz Veri", message: "Sunucudan alınan veri geçersiz. Lütfen tekrar deneyin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            case .authError:
                AlertManager.present(title: "Kimlik Doğrulama Hatası", message: "Kimlik doğrulama hatası oluştu. Lütfen giriş bilgilerinizi kontrol edin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            case .unknownError:
                AlertManager.present(title: "Bilinmeyen Hata", message: "Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            case .decodingError:
                AlertManager.present(title: "Veri Çözümleme Hatası", message: "Sunucudan alınan veriyi işleyemedik. Lütfen tekrar deneyin.", style: .alert, viewController: self)
                LottieManager.removeFullScreenLottie()
            }
        }
    }
}

extension UserListVC: UserTableViewDelegate {
    
    func numberOfRows() -> Int {
        viewModel.numberOfRows()
    }
    
    func item(for row: Int) -> UserList {
        viewModel.item(for: row)
    }
    
    func didSelectUserList(userList: UserList) {
        DispatchQueue.main.async {
            LottieManager.showFullScreenLottie(animation: .loadingCircle2)
        }
        let destinationVC = UserListDetailVC()
        destinationVC.user = userList
        present(destinationVC: destinationVC, slideDirection: .right)
    }
}

