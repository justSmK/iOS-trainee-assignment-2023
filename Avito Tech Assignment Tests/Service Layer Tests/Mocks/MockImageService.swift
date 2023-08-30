//
//  MockImageService.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit
import XCTest
@testable import Avito_Tech_Assignment

final class MockImageService: ImageServiceProtocol {
    
    var fetchImageResult: Result<UIImage, APIError>?
    var fetchImageFromURLResult: Result<UIImage, APIError>?
    
    var imageExpectation: XCTestExpectation?
    
    func fetchImage(itemId: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        if let result = fetchImageResult {
            completion(result)
            imageExpectation?.fulfill()
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        if let result = fetchImageFromURLResult {
            completion(result)
            imageExpectation?.fulfill()
            print("fetchImage fullfill")
        }
    }
}
