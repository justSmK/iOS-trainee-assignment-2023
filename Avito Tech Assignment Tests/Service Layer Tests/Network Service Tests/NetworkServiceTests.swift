//
//  NetworkServiceTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class NetworkServiceTests: XCTestCase {

    var networkService: NetworkServiceProtocol!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testPerformRequestSuccess() {
        let expectation = XCTestExpectation(description: "Expecting a successful request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        networkService.performRequest(url: url, httpMethod: .get) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestFailure() {
        let expectation = XCTestExpectation(description: "Expecting a failed request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/badURL")!
        
        networkService.performRequest(url: url, httpMethod: .get) { result in
            switch result {
            case .success(_):
                XCTFail("Request should not be successful")
            case .failure(let error):
                XCTAssertNotNil(error, "No error received")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestGet() {
        let expectation = XCTestExpectation(description: "Expecting a successful GET request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        networkService.performRequest(url: url, httpMethod: .get) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestPost() {
        let expectation = XCTestExpectation(description: "Expecting a successful POST request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        networkService.performRequest(url: url, httpMethod: .post) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestPut() {
        let expectation = XCTestExpectation(description: "Expecting a successful PUT request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        networkService.performRequest(url: url, httpMethod: .put) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestPatch() {
        let expectation = XCTestExpectation(description: "Expecting a successful PATCH request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        networkService.performRequest(url: url, httpMethod: .patch) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformRequestDelete() {
        let expectation = XCTestExpectation(description: "Expecting a successful DELETE request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        networkService.performRequest(url: url, httpMethod: .delete) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testNetworkServiceMemoryLearTeardown() {
        let localNetworkService = NetworkService()
        let expectation = XCTestExpectation(description: "Expecting a successful request")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        localNetworkService.performRequest(url: url, httpMethod: .get) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "No data received")
            case .failure(let error):
                XCTFail("Request failed: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        addTeardownBlock { [weak localNetworkService] in
            XCTAssertNil(localNetworkService, "potential memory leak on \(String(describing: localNetworkService))")
        }
    }
    
}
