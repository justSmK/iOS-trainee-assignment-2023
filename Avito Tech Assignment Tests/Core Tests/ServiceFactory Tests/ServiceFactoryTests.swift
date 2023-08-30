//
//  ServiceFactoryTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class ServiceFactoryTests: XCTestCase {
    
    var factory: DefaultServiceFactory!
    
    override func setUp() {
        super.setUp()
        factory = DefaultServiceFactory()
    }
    
    override func tearDown() {
        factory = nil
        super.tearDown()
    }
    
    func testCreateNetworkService() {
        let networkService = factory.createNetworkService()
        XCTAssertNotNil(networkService)
        XCTAssertTrue(networkService is NetworkService)
    }
    
    func testCreateImageClient() {
        let networkService = MockNetworkService()
        let imageClient = factory.createImageClient(networkService: networkService)
        XCTAssertNotNil(imageClient)
        XCTAssertTrue(imageClient is ImageAPIClient)
    }
    
    func testCreateImageService() {
        let imageClient = MockImageAPIClient()
        let imageService = factory.createImageService(imageClient: imageClient)
        XCTAssertNotNil(imageService)
        XCTAssertTrue(imageService is ImageService)
    }
    
    func testCreateAdvertisementClient() {
        let networkService = MockNetworkService()
        let adClient = factory.createAdvertisementClient(networkService: networkService)
        XCTAssertNotNil(adClient)
        XCTAssertTrue(adClient is AdvertisementAPIClient)
    }
    
    func testCreateAdvertisementService() {
        let adClient = MockAdvertisementAPIClient()
        let adService = factory.createAdvertisementService(adClient: adClient)
        XCTAssertNotNil(adService)
        XCTAssertTrue(adService is AdvertisementService)
    }
    
}
