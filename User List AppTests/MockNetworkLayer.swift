//
//  MockNetworkLayer.swift
//  User List AppTests
//
//  Created by serhat yaroglu on 8.02.2025.
//

import Foundation
@testable import User_List_App

class MockNetworkLayer: NetworkProtocol {
    
    var shouldReturnError = false
    var mockUserList: [UserList] = []
    
    func getRequest(_ endpoint: NetworkEndPoint, completion: @escaping (Result<[UserList], NetworkError>) -> Void) {
        
        if shouldReturnError {
            completion(.failure(.decodingError)) 
        } else {
            completion(.success(mockUserList)) 
        }
    }
}
