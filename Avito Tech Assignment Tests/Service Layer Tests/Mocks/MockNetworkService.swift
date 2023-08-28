//
//  MockNetworkService.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation
@testable import Avito_Tech_Assignment

final class MockNetworkService: NetworkServiceProtocol {
    
    var mockData: Data?
    var mockError: Error?
    
    func performRequest(url: URL,
                        httpMethod: Avito_Tech_Assignment.HTTP.Method,
                        completion: @escaping (Result<Data, Avito_Tech_Assignment.APIError>) -> Void
    ) {
        if let mockData {
            completion(.success(mockData))
        } else if let mockError {
            completion(.failure(mockError as! APIError))
        }
    }
}
