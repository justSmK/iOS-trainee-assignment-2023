//
//  MockImageAPIClient.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation
@testable import Avito_Tech_Assignment

final class MockImageAPIClient: ImageAPIClientProtocol {
    
    var mockImageData: Data?
    var mockError: APIError?
    
    func fetchImageData(from url: URL,
                        completion: @escaping (Result<Data, Avito_Tech_Assignment.APIError>) -> Void
    ) {
        if let mockImageData {
            completion(.success(mockImageData))
        } else if let mockError {
            completion(.failure(mockError))
        }
    }
}
