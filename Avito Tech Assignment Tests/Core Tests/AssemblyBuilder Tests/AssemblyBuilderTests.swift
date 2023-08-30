//
//  AssemblyBuilderTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class AssemblyBuilderTests: XCTestCase {

    var serviceFactory: MockServiceFactory!
    var assemblyBuilder: AssemblyBuilderProtocol!
    
    override func setUp() {
        super.setUp()
        serviceFactory = MockServiceFactory()
        serviceFactory.mockNetworkService = MockNetworkService()
        serviceFactory.mockAdvertisementClient = MockAdvertisementAPIClient()
        serviceFactory.mockImageClient = MockImageAPIClient()
        serviceFactory.mockAdvertisementService = MockAdvertisementService()
        serviceFactory.mockImageService = MockImageService()
        assemblyBuilder = AssemblyBuilder(serviceFactory: serviceFactory)
    }
    
    override func tearDown() {
        serviceFactory = nil
        assemblyBuilder = nil
        super.tearDown()
    }
    
    func testCreateInitialSetup() {
        let (navController, router) = assemblyBuilder.createInitialSetup()
        
        XCTAssertNotNil(navController)
        XCTAssertNotNil(router)
    }
    
    func testCreateAdvertisementsViewController() {
        let mockRouter = MockRouter()
        let vc = assemblyBuilder.createAdvertisementsViewController(router: mockRouter)
        
        XCTAssertTrue(vc is AdvertisementsViewController)
    }
    
    func testCreateAdvertisementDetailViewController() {
        let advertisementId = "testId"
        let mockRouter = MockRouter()
        let vc = assemblyBuilder.createAdvertisementDetailViewController(advertisementId: advertisementId, router: mockRouter)
        
        XCTAssertTrue(vc is AdvertisementDetailViewController)
    }

}
