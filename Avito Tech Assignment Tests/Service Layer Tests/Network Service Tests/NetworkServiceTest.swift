//
//  NetworkServiceTest.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/27/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class NetworkServiceTest: XCTestCase {
    
    var networkService: NetworkServiceProtocol!
    
    override func setUp() {
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
    }
    
    func testFetchAdvertisements() throws {
        let expectation = XCTestExpectation(description: "fetchAdvertisements returns data")
        
        networkService.fetchAdvertisements { result in
            switch result {
                
            case .success(let advertisements):
                XCTAssertNotNil(advertisements, "No data received")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchAdvertisementDetail() throws {
        let itemId = "1"
        
        let expectation = XCTestExpectation(description: "fetchAdvertisementDetail returns data")
        
        networkService.fetchAdvertisementDetail(itemId: itemId) { result in
            switch result {
            case .success(let advertisement):
                XCTAssertNotNil(advertisement, "No data received")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testServerError() {
        let itemId = String(Int.min)
        
        let expectation = XCTestExpectation(description: "fetchAdvertisementDetail returns error")
        
        networkService.fetchAdvertisementDetail(itemId: itemId) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case APIError.serverError = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Received unexpected error: \(error)")
                }

            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testInternetConnectionError() {
        let itemId = String("1")
        let expectation = XCTestExpectation(description: "Returns no internet connection error")
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let urlSessionMock = URLSessionMock(error: error, response: nil, data: nil)
        
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisementDetail(itemId: itemId) { result in
            switch result {
                
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case APIError.noInternetConnection = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Received unexpected error: \(error)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    

}
