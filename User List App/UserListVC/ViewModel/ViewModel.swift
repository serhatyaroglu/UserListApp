//
//  ViewModelDelegate.swift
//  User List App
//
//  Created by serhat yaroglu on 7.02.2025.
//


import Foundation
import Lottie

protocol ViewModelDelegate: AnyObject {
    func userListDidFetch()
    func errorOccurred(error: NetworkError)
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    
    var arrUserList: [UserList] = []
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = NetworkLayer.shared) {
        self.network = network
    }
    func fetchUserList(for userState: NetworkEndPoint) {
        network.getRequest(userState) { result in
            switch result {
                //MARK: -  Gelen dataları burada döndürüyorum
            case .success(let arrUserList):
                DispatchQueue.main.async {
                    LottieManager.removeFullScreenLottie()
                }
                self.arrUserList = arrUserList
                self.delegate?.userListDidFetch()
                //MARK: -  Gelen error burada döndürüyoruz
            case .failure(let error):
                self.delegate?.errorOccurred(error: error)
            }
        }
    }
    //MARK: - tableview datasource içib row sayısı
    func numberOfRows() -> Int {
        return arrUserList.count
    }
    //MARK: - tableview cellerin içinde gösterilecek olan item
    func item(for row: Int) -> UserList {
        return arrUserList[row]
    }
    //MARK: - tableview seçileni döndürür
    func didSelectRow(at: Int) -> UserList {
        return arrUserList[at]
    }
}
