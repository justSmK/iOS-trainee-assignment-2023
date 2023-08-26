//
//  NetworkService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisements, completion: completion)
    }
    
    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisementDetail(itemId: itemId), completion: completion)
    }
    
    private func request<T: Decodable>(endpoint: EndpointAdvertisement, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(.urlSessionError("Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Method.get.rawValue
        
        
        #if DEBUG
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        #endif
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noInternetConnection(error.localizedDescription)))
                } else {
                    completion(.failure(.urlSessionError(error.localizedDescription)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.status?.responseType == .success else {
                completion(.failure(.serverError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse()))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
//                print("Raw data: \(String(data: data, encoding: .utf8) ?? "n/a")")
//                print("Decoding error: \(error)")
                completion(.failure(.decodingError()))
            }
        }
        
        task.resume()
    }
    
}
