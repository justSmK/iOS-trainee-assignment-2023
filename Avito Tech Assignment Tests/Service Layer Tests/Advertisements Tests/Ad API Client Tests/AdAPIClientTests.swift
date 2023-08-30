//
//  AdAPIClientTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class AdAPIClientTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var advertisementApiClient: AdvertisementAPIClientProtocol!
    static let testURL = URL(string: "https://Foo.com")!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        advertisementApiClient = AdvertisementAPIClient(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        advertisementApiClient = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        let testData = Data([0x01, 0x02])
        mockNetworkService.mockData = testData
        
        advertisementApiClient.fetchData(from: Self.testURL) { result in
            if case .success(let data) = result {
                XCTAssertEqual(data, testData)
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchDataFailure() {
        let expectation = self.expectation(description: "Expecting Failure")
        
        mockNetworkService.mockError = APIError.urlSessionError("An error occurred")
        
        advertisementApiClient.fetchData(from: Self.testURL) { result in
            if case .failure(let error) = result {
                if case APIError.urlSessionError = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testAdvertisementApiClientMemoryLearTeardown() {
        let localMockNetworkService = MockNetworkService()
        let localAdvertisementApiClient = AdvertisementAPIClient(networkService: localMockNetworkService)

        let expectation = self.expectation(description: "Expecting Success")
        
        let testData = Data([0x01, 0x02])
        localMockNetworkService.mockData = testData
        
        localAdvertisementApiClient.fetchData(from: Self.testURL) { result in
            if case .success(let data) = result {
                XCTAssertEqual(data, testData)
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
        
        addTeardownBlock { [weak localMockNetworkService, weak localAdvertisementApiClient] in
            XCTAssertNil(localMockNetworkService, "potential memory leak on \(String(describing: localMockNetworkService))")
            XCTAssertNil(localAdvertisementApiClient, "potential memory leak on \(String(describing: localAdvertisementApiClient))")
        }
    }
}
