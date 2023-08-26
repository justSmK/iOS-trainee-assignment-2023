//
//  ImageService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/25/23.
//

import UIKit.UIImage

final class ImageService: ImageServiceProtocol {
    private var cache = NSCache<NSURL, UIImage>()
    
    func fetchImage(itemId: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        loadImage(endpoint: .fetchImage(itemId: itemId), completion: completion)
    }
    
    private func loadImage(endpoint: EndpointImage, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.urlSessionError("Invalid URL")))
            return
        }
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTP.Method.get.rawValue
        
        
        #if DEBUG
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        #endif
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
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
            
            if let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url as NSURL)
                completion(.success(image))
            } else {
                completion(.failure(.decodingError("Failed to decode image")))
            }
        }
        
        task.resume()
    }
    

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
            
            if let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url as NSURL)
                completion(.success(image))
            } else {
                completion(.failure(.decodingError("Failed to decode image")))
            }
        }
        task.resume()
    }
    
    func prefetchImage(from url: URL) {
        print("Prefetch", url.description.suffix(6))
        if let _ = cache.object(forKey: url as NSURL) {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url as NSURL)
            }
            
        }
        
        task.resume()
    }
}
