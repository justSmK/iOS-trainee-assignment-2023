//
//  RouterTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class RouterTests: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController: UINavigationController!
    var assemblyBuilder: MockAssemblyBuilder!

    override func setUp() {
        super.setUp()
        
        navigationController = UINavigationController()
        assemblyBuilder = MockAssemblyBuilder()
        
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }
    
    override func tearDown() {
        navigationController = nil
        assemblyBuilder = nil
        router = nil
        super.tearDown()
    }

    func testInitialController() {
        router.initialViewController()
        
        XCTAssert(navigationController.viewControllers.first is AdvertisementsViewController)
    }
    
    func testShowAdvertisementDetails() {
        let id = "testId"
        
        router.showAdvertisementDetails(advertisementId: id)
        
        XCTAssert(navigationController.viewControllers.first is AdvertisementDetailViewController)
    }
    
    func testPopToRoot() {
        let expectation = self.expectation(description: "Wait for UI update")
        
        router.initialViewController()
        XCTAssert(navigationController.viewControllers.count == 1)
        
        let id = "testId"
        router.showAdvertisementDetails(advertisementId: id)
        
        DispatchQueue.main.async {
            XCTAssert(self.navigationController.viewControllers.count == 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        router.popToRoot()
        XCTAssert(navigationController.viewControllers.count == 1)
    }

}
