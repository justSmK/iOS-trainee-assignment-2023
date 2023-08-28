//
//  AdvertisementService.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

final class AdvertisementService: AdvertisementServiceProtocol {
    
    // MARK: - Private Properties
    
    private let advertisementClient: AdvertisementAPIClientProtocol
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Initializer
    
    init(advertisementClient: AdvertisementAPIClientProtocol, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.advertisementClient = advertisementClient
        self.jsonDecoder = jsonDecoder
        setupJsonDecoder()
    }
    
    // MARK: - AdvertisementServiceProtocol
    
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisements, completion: completion)
    }

    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void) {
        request(endpoint: .fetchAdvertisementDetail(itemId: itemId), completion: completion)
    }
    
    // MARK: - Private Methods
    
    private func request<T: Decodable>(endpoint: EndpointAdvertisement, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.urlSessionError("Invalid URL")))
            return
        }
        
        advertisementClient.fetchData(from: url) { result in
            switch result {
                
            case .success(let data):
                do {
                    let responseObject = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(.decodingError(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func setupJsonDecoder() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
}
