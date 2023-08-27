//
//  NetworkService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    private let jsonDecoder: JSONDecoder
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        self.jsonDecoder = JSONDecoder()
        setupJsonDecoder()
    }
    
    private func setupJsonDecoder() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
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
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error {
                if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noInternetConnection(error.localizedDescription)))
                } else {
                    completion(.failure(.urlSessionError(error.localizedDescription)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.status?.responseType == .success else {
                let response = response as? HTTPURLResponse
                completion(.failure(.serverError("Received HTTP status: \(String(describing: response?.status))")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            
            do {
                let responseObject = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }
        
        task.resume()
    }
    
}
