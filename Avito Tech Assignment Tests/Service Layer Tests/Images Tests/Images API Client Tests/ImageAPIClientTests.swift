//
//  ImageAPIClientTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class ImageAPIClientTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var imageApiClient: ImageAPIClientProtocol!
    static let testURL = URL(string: "https://Foo.com")!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        imageApiClient = ImageAPIClient(networkService: mockNetworkService)
    }

    override func tearDown() {
        super.tearDown()
        mockNetworkService = nil
        imageApiClient = nil
    }

    func testFetchDataSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        let testData = Data([0x01, 0x02])
        mockNetworkService.mockData = testData
        
        imageApiClient.fetchImageData(from: Self.testURL) { result in
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
        
        imageApiClient.fetchImageData(from: Self.testURL) { result in
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

    func testImageAPIClientMemoryLearTeardown() {
        let localMockNetworkService = MockNetworkService()
        let localImageApiClient = ImageAPIClient(networkService: localMockNetworkService)
        
        let expectation = self.expectation(description: "Expecting Success")
        
        let testData = Data([0x01, 0x02])
        localMockNetworkService.mockData = testData
        
        localImageApiClient.fetchImageData(from: Self.testURL) { result in
            if case .success(let data) = result {
                XCTAssertEqual(data, testData)
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
        
        addTeardownBlock { [weak localMockNetworkService, weak localImageApiClient] in
            XCTAssertNil(localMockNetworkService, "potential memory leak on \(String(describing: localMockNetworkService))")
            XCTAssertNil(localImageApiClient, "potential memory leak on \(String(describing: localImageApiClient))")
        }
    }
    
}
