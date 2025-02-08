//
//  NetworkHelper.swift
//  User List Api
//
//  Created by serhat yaroglu on 08.02.2025.
//

import Foundation
//MARK: - Network error durumları için Errorlar
enum NetworkError: Error {
    case unableToCompleteError
    case invalidResponse
    case invalidData
    case authError
    case unknownError
    case decodingError
}

enum HTTPMethod: String {
    case get = "GET"
}
//MARK: - Network kullanılacak enpointleri döndürür
protocol NetworkEndpointDelegate {
    var baseURL: String { get }
    var method: HTTPMethod { get }
}

enum NetworkEndPoint {
    case users
}
//MARK: - Network kullanılacak enpointleri veriyoruz 
extension NetworkEndPoint: NetworkEndpointDelegate {
      
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/users"
    }
    
    var method: HTTPMethod {
        switch self {
        case .users:
                .get
        }
    }
    
    func request() -> URLRequest {
        guard let url = URL(string: baseURL) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
