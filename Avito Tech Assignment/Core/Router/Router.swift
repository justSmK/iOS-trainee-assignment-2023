//
//  Router.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController? = nil, assemblyBuilder: AssemblyBuilderProtocol? = nil) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController {
            guard let advertisementsViewController = assemblyBuilder?.createAdvertisementsViewController(router: self) else { return }
            navigationController.viewControllers = [advertisementsViewController]
        }
    }
    
    func showAdvertisementDetails(advertisementId: String) {
        if let navigationController {
            guard let advertisementDetailViewController = assemblyBuilder?
                .createAdvertisementDetailViewController(
                    advertisementId: advertisementId,
                    router: self
                ) else { return}
            navigationController.pushViewController(advertisementDetailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
