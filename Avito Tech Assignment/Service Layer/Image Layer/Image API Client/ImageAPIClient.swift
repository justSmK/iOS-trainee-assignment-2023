//
//  ImageAPIClient.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

final class ImageAPIClient: ImageAPIClientProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    
    func fetchImageData(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        networkService.performRequest(url: url, httpMethod: .get) { result in
            switch result {
                
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
