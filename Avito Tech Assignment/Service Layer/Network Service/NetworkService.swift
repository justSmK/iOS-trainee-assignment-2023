//
//  NetworkService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func performRequest(url: URL, httpMethod: HTTP.Method, completion: @escaping (Result<Data, APIError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
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
                completion(.failure(.serverError("Received HTTP status: \(String(describing: response?.status?.responseType))")))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            
            completion(.success(data))
        }

        task.resume()
    }
}
