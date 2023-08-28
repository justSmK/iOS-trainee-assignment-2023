//
//   ImageService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit.UIImage

final class ImageService: ImageServiceProtocol {

    private var cache = NSCache<NSURL, UIImage>()
    
    private var imageClient: ImageAPIClientProtocol
    
    init(imageClient: ImageAPIClientProtocol) {
        self.imageClient = imageClient
    }
    
    func fetchImage(itemId: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        guard let url = EndpointImage.fetchImage(itemId: itemId).url else {
            completion(.failure(.urlSessionError("Invalid URL")))
            return
        }
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
        }
        
        imageClient.fetchImageData(from: url) { [weak self] result in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: url as NSURL)
                    completion(.success(image))
                } else {
                    completion(.failure(.decodingError("Failed to decode image")))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
        }
        
        imageClient.fetchImageData(from: url) { [weak self] result in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: url as NSURL)
                    completion(.success(image))
                } else {
                    completion(.failure(.decodingError("Failed to decode image")))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
