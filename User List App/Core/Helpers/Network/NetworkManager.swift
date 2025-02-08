//
//  NetworkManager.swift
//  User List Api
//
//  Created by serhat yaroglu on 08.02.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    static var shared: NetworkManager { get }
    func request<T: Codable>(_ endpoint: NetworkEndPoint, completion: @escaping (Swift.Result<T, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    static var shared: NetworkManager = .init()
    
    private var session = URLSession.shared
    private let decoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
            self.session = session
        }
    func request<T: Codable>(_ endpoint: NetworkEndPoint, completion: @escaping (Swift.Result<T, NetworkError>) -> Void)  {
        
        let task = session.dataTask(with: endpoint.request()) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.unableToCompleteError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let result = try self.decoder.decode(T.self, from: data)
         
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case 401:
                completion(.failure(.authError))
            default:
                print(response.statusCode)
                completion(.failure(.unknownError))
            }
        }
        task.resume()
    }
}
