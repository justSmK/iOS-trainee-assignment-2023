//
//  MockRouter.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit.UINavigationController
@testable import Avito_Tech_Assignment

final class MockRouter: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    var initialViewControllerCalled = false
    var showAdvertisementDetailsCalled = false
    var popToRootCalled = false
    var lastAdvertisementId: String?
    
    func initialViewController() {
        initialViewControllerCalled = true
    }
    
    func showAdvertisementDetails(advertisementId: String) {
        showAdvertisementDetailsCalled = true
        lastAdvertisementId = advertisementId
    }
    
    func popToRoot() {
        popToRootCalled = true
    }
}
