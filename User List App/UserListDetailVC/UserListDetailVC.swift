//
//  UserListDetailVC.swift
//  User List App
//
//  Created by serhat yaroglu on 8.02.2025.
//

import UIKit
import SnapKit

class UserListDetailVC: UIViewController {
    
    var user: UserList?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private let emailLabel = UserDetailLabel(title: "📧 Email:")
    private let phoneLabel = UserDetailLabel(title: "📞 Telefon:")
    private let websiteLabel = UserDetailLabel(title: "🌍 Websitesi:")
    private let addressLabel = UserDetailLabel(title: "🏠 Adres:")
    private let companyLabel = UserDetailLabel(title: "🏢 Şirket:")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        DispatchQueue.main.async {
            LottieManager.removeFullScreenLottie()
        }
        view.backgroundColor = .white
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            view.addSubview(backButton)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(cardView)
        
        cardView.addSubview(emailLabel)
        cardView.addSubview(phoneLabel)
        cardView.addSubview(websiteLabel)
        cardView.addSubview(addressLabel)
        cardView.addSubview(companyLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(companyLabel.snp.bottom).offset(16)
            
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(websiteLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
            
        }
    }
    
    @objc private func backTapped() {
        dismiss(animated: true)
    }
    //MARK: - userlistdetailvc burada configure ediliyor
    private func setupData() {
        guard let user = user else { return }
        usernameLabel.text = user.username
        emailLabel.setText(user.email)
        phoneLabel.setText(user.phone)
        websiteLabel.setText(user.website)
        addressLabel.setText("\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)")
        companyLabel.setText(user.company.name)
    }
}
