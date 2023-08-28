//
//  MockAdvertisementAPIClient.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation
@testable import Avito_Tech_Assignment

final class MockAdvertisementAPIClient: AdvertisementAPIClientProtocol {
    
    var mockData: Data?
    var mockError: APIError?
    
    func fetchData(from url: URL,
                   completion: @escaping (Result<Data, Avito_Tech_Assignment.APIError>) -> Void
    ) {
        if let mockData {
            completion(.success(mockData))
        } else if let mockError {
            completion(.failure(mockError))
        }
    }
}
