//
//  MockAssemblyBuilder.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit
@testable import Avito_Tech_Assignment

final class MockAssemblyBuilder: AssemblyBuilderProtocol {
    func createInitialSetup() -> (UINavigationController, Avito_Tech_Assignment.RouterProtocol) {
        return (UINavigationController(), Router())
    }
    
    func createAdvertisementsViewController(router: Avito_Tech_Assignment.RouterProtocol) -> UIViewController {
        return AdvertisementsViewController()
    }
    
    func createAdvertisementDetailViewController(advertisementId: String, router: Avito_Tech_Assignment.RouterProtocol) -> UIViewController {
        return AdvertisementDetailViewController()
    }
}
