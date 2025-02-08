//
//  NetworkLayer.swift
//  User List Api
//
//  Created by serhat yaroglu on 08.02.2025.
//

import Foundation


protocol NetworkProtocol {
    func getRequest(_ endpoint: NetworkEndPoint, completion: @escaping (Swift.Result<[UserList], NetworkError>) -> Void)
}

final class NetworkLayer: NetworkProtocol {
    
    static let shared = NetworkLayer()
    private init() {}
    
    func getRequest(_ endpoint: NetworkEndPoint, completion: @escaping (Swift.Result<[UserList], NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint, completion: completion)
    }
}
