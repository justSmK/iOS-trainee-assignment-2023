//
//  ImageServiceTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/28/23.
//

import XCTest
import UIKit.UIImage
@testable import Avito_Tech_Assignment

final class ImageServiceTests: XCTestCase {
    
    var mockImageClient: MockImageAPIClient!
    var imageService: ImageServiceProtocol!
    static let testURL = URL(string: "https://Foo.Bar/image.png")!
    static let mockImageData = UIImage(systemName: "house")!.pngData()!

    override func setUp() {
        super.setUp()
        mockImageClient = MockImageAPIClient()
        imageService = ImageService(imageClient: mockImageClient)
    }
    
    override func tearDown() {
        mockImageClient = nil
        mockImageClient = nil
        super.tearDown()
    }

    func testFetchImageSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        mockImageClient.mockImageData = Self.mockImageData
        
        imageService.fetchImage(itemId: "1") { result in
            if case .success(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    func testFetchImageFailure() {
        let expectation = self.expectation(description: "Expecting Failure")
        
        mockImageClient.mockError = APIError.urlSessionError("Failed")
        
        imageService.fetchImage(itemId: "1") { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchImageFromURLSuccess() {
        let expectation = self.expectation(description: "Expecting Success")
        
        mockImageClient.mockImageData = Self.mockImageData
        
        imageService.fetchImage(from: Self.testURL) { result in
            if case .success(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchImageFromURLFailure() {
        let expectation = self.expectation(description: "Expecting Failure")
        
        mockImageClient.mockError = APIError.urlSessionError("Failed")
        
        imageService.fetchImage(from: Self.testURL) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testImageServiceMemoryLearTeardown() {
        let localMockImageClient = MockImageAPIClient()
        let localImageService = ImageService(imageClient: localMockImageClient)

        let expectation = self.expectation(description: "Expecting Success")
        
        localMockImageClient.mockImageData = Self.mockImageData
        
        localImageService.fetchImage(itemId: "1") { result in
            if case .success(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Expecting success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1)
        
        addTeardownBlock { [weak localMockImageClient, weak localImageService] in
            XCTAssertNil(localMockImageClient, "potential memory leak on \(String(describing: localMockImageClient))")
            XCTAssertNil(localImageService, "potential memory leak on \(String(describing: localImageService))")
        }
    }
}
