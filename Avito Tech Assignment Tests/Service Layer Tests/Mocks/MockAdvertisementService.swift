//
//  MockAdvertisementService.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import Foundation
import XCTest
@testable import Avito_Tech_Assignment

final class MockAdvertisementService: AdvertisementServiceProtocol {
    var fetchAdvertisementsResult: Result<AdvertisementsResponse, APIError>?
    var fetchAdvertisementDetailResult: Result<AdvertisementDetail, APIError>?
    
    var isFetchAdvertisementsCalled = false
    var isFetchAdvertisementDetailCalled = false
    
    var lastItemId: String?
    
    var adDetailExpectation: XCTestExpectation?
    
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void) {
        isFetchAdvertisementsCalled = true
        if let result = fetchAdvertisementsResult {
            completion(result)
        }
    }
    
    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void) {
        isFetchAdvertisementDetailCalled = true
        lastItemId = itemId
        if let result = fetchAdvertisementDetailResult {
            completion(result)
            adDetailExpectation?.fulfill()
            print("fetchAdvertisementDetail fullfill")
        }
    }
}
