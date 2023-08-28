//
//  NetworkServiceErrorTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class NetworkServiceErrorTests: XCTestCase {
    
    var mockSession: MockURLSession!
    var networkService: NetworkServiceProtocol!
    
    static var url: URL!
    
    override class func setUp() {
        super.setUp()
        url = URL(string: "https://Foo.com")
    }
    
    override class func tearDown() {
        super.tearDown()
        url = nil
    }

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkService = NetworkService(session: mockSession)
    }
    
    override func tearDown() {
        mockSession = nil
        networkService = nil
    }

    func testNoInternetConnection() {
        let expectation = self.expectation(description: "Expecting No Internet Connection Error")
        
        mockSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        networkService.performRequest(url: Self.url, httpMethod: .get) { result in
            if case .failure(let error) = result {
                if case APIError.noInternetConnection = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testURLSessionError() {
        let expectation = self.expectation(description: "Expecting URLSession Error")
        
        mockSession.error = NSError(domain: "SomeOtherError", code: 1, userInfo: nil)
        
        networkService.performRequest(url: Self.url, httpMethod: .get) { result in
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
    
    func testServerError() {
        let expectation = self.expectation(description: "Expecting Server Error")
        
        mockSession.response = HTTPURLResponse(url: Self.url, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        networkService.performRequest(url: Self.url, httpMethod: .get) { result in
            if case .failure(let error) = result {
                if case APIError.serverError = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testInvalidResponse() {
        let expectation = self.expectation(description: "Expecting Invalid Response Error")
        
        mockSession.response = HTTPURLResponse(url: Self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.data = nil
        
        networkService.performRequest(url: Self.url, httpMethod: .get) { result in
            if case .failure(let error) = result {
                if case APIError.invalidResponse = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testDecodingError() {
        let expectation = self.expectation(description: "Expecting Invalid Response Error")
        
        mockSession.response = HTTPURLResponse(url: Self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.data = nil
        
        networkService.performRequest(url: Self.url, httpMethod: .get) { result in
            if case .failure(let error) = result {
                if case APIError.invalidResponse = error {
                    expectation.fulfill()
                }
            } else {
                XCTFail("Expecting failure but got success")
            }
        }
        
        waitForExpectations(timeout: 1)
    }

}
