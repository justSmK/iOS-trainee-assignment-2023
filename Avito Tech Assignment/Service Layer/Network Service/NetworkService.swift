//
//  NetworkService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
//    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
}

class NetworkService: NetworkServiceProtocol {
    
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisements, completion: completion)
    }
    
    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisementDetail(itemId: itemId), completion: completion)
    }
    
    private func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.urlSessionError("Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Method.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            
//            if let response = response as? HTTPURLResponse, response.statusCode != 200 && response.statusCode != 201 {
//                completion(.failure(.serverError()))
//            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse()))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.decodingError()))
            }
        }
        
        task.resume()
    }
}
