//
//  ImageServiceTest.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/27/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class ImageServiceTest: XCTestCase {
    
    var imageService: ImageServiceProtocol!
    
    override func setUp() {
        imageService = ImageService()
    }

    override func tearDown() {
        imageService = nil
    }

    func testFetchImageByItemId() throws {
        let itemId = "1"
        
        let expectation = XCTestExpectation(description: "fetchImage returns data")
        
        imageService.fetchImage(itemId: itemId) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchImageByURL() throws {
        let expectation = XCTestExpectation(description: "fetchImage returns data")
        
        let testUrl: URL = URL(string: "https://www.avito.st/s/interns-ios/images/1.png")!
        
        imageService.fetchImage(from: testUrl) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "No image received")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
