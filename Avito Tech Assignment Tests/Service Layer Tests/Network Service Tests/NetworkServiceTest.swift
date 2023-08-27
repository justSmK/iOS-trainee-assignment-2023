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
        
        wait(for: [expectation], timeout: 1)
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
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testServerErrorWithInvalidURL() {
        let fakeItemId = String(Int.min)
        
        let expectation = XCTestExpectation(description: "Invalid URL error expected")
        
        networkService.fetchAdvertisementDetail(itemId: fakeItemId) { result in
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
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testInternetConnectionError() {
        let expectation = XCTestExpectation(description: "Returns no internet connection error")
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let urlSessionMock = URLSessionMock(error: error, response: nil, data: nil)
        
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisements { result in
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
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testServerError() {
        let expectation = XCTestExpectation(description: "Server error expected")
        
        let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let urlSessionMock = URLSessionMock(error: nil, response: response, data: nil)
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisements { result in
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
        
        wait(for: [expectation], timeout: 1)
    }

    func testInvalidResponse() {
        let expectation = XCTestExpectation(description: "Invalid response expected")
        
        let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSessionMock = URLSessionMock(error: nil, response: response, data: nil)
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisements { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case APIError.invalidResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Received unexpected error: \(error)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDecodingError() {
        let expectation = XCTestExpectation(description: "Decoding error expected")
        
        let jsonData = "{\"invalid_key\": \"invalid_value\"}".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSessionMock = URLSessionMock(error: nil, response: response, data: jsonData)
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisements { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case APIError.decodingError = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Received unexpected error: \(error)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testURLSessionError() {
        let expectation = XCTestExpectation(description: "URL Session error expected")
        
        let customError = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
        let urlSessionMock = URLSessionMock(error: customError, response: nil, data: nil)
        let localNetworkService = NetworkService(session: urlSessionMock)
        
        localNetworkService.fetchAdvertisements { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case APIError.urlSessionError = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Received unexpected error: \(error)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
