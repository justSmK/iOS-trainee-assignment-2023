//
//  AdServiceTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class AdServiceTests: XCTestCase {

    var mockAdClient: MockAdvertisementAPIClient!
    var adService: AdvertisementServiceProtocol!
    
    override func setUp() {
        super.setUp()
        mockAdClient = MockAdvertisementAPIClient()
        adService = AdvertisementService(advertisementClient: mockAdClient)
    }
    
    override func tearDown() {
        mockAdClient = nil
        adService = nil
        super.tearDown()
    }
    
    func testFetchAdvertisementsSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        let jsonData = mockAdvertisementsResponseJSON.data(using: .utf8)!
        
        mockAdClient.mockData = jsonData
        
        adService.fetchAdvertisements { result in
            if case .success(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchAdvertisementFailure() {
        let expectation = self.expectation(description: "Expecting Failure")
        
        mockAdClient.mockError = APIError.decodingError("An error occurred")
        
        adService.fetchAdvertisements { result in
            if case .failure(let error) = result {
                if case APIError.decodingError = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchAdvertisementDetailSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        let jsonData = mockAdvertisementDetailJSON.data(using: .utf8)!
        
        mockAdClient.mockData = jsonData
        
        adService.fetchAdvertisementDetail(itemId: "1") { result in
            if case .success(let data) = result {
                XCTAssertEqual(data.id, "1")
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    func testFetchAdvertisementDetailFailure() {
        let expectation = self.expectation(description: "Expecting Failure")
        
        mockAdClient.mockError = APIError.decodingError("An error occurred")
        
        adService.fetchAdvertisementDetail(itemId: "1") { result in
            if case .failure(let error) = result {
                if case APIError.decodingError = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testAdvertisementServiceMemoryLearTeardown() {
        let localMockAdClient = MockAdvertisementAPIClient()
        let localAdService = AdvertisementService(advertisementClient: localMockAdClient)
        
        let expectation = self.expectation(description: "Expecting Success")
        
        let jsonData = mockAdvertisementsResponseJSON.data(using: .utf8)!
        
        mockAdClient.mockData = jsonData
        
        adService.fetchAdvertisements { result in
            if case .success(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
        
        addTeardownBlock { [weak localMockAdClient, weak localAdService] in
            XCTAssertNil(localMockAdClient, "potential memory leak on \(String(describing: localMockAdClient))")
            XCTAssertNil(localAdService, "potential memory leak on \(String(describing: localAdService))")
        }
    }
}
