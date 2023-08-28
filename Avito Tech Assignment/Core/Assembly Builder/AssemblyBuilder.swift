//
//  AssemblyBuilder.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    // MARK: - Private Properties
    private let serviceFactory: ServiceFactoryProtocol
    
    // MARK: - Dependencies
    init(serviceFactory: ServiceFactoryProtocol = DefaultServiceFactory()) {
        self.serviceFactory = serviceFactory
    }
    
    // MARK: - AssemblyBuilderProtocol
    func createInitialSetup() -> (UINavigationController, Router) {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        return (navigationController, router)
    }
    
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController {
        let networkService = serviceFactory.createNetworkService()
        
        let imageClient = serviceFactory
            .createImageClient(networkService: networkService)
        let imageService = serviceFactory
            .createImageService(imageClient: imageClient)
        
        let advertisementClient = serviceFactory
            .createAdvertisementClient(networkService: networkService)
        let advertisementService = serviceFactory
            .createAdvertisementService(adClient: advertisementClient)
        
        let view = AdvertisementView()
        
        let viewController = AdvertisementsViewController(
            advertisementService: advertisementService,
            imageService: imageService,
            view: view
        )
        
        return viewController
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
}
