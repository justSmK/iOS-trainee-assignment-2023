//
//  AdvertisementAPIClient.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

final class AdvertisementAPIClient: AdvertisementAPIClientProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializer
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - AdvertisementAPIClientProtocol
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        networkService.performRequest(url: url, httpMethod: .get, completion: completion)
    }
}
