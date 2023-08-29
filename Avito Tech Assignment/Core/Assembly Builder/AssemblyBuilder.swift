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
    
    private lazy var networkService = serviceFactory.createNetworkService()
    
    private lazy var imageService = {
        let imageClient = serviceFactory.createImageClient(networkService: networkService)
        return serviceFactory.createImageService(imageClient: imageClient)
    }()
    
    private lazy var advertisementService = {
        let advertisementClient = serviceFactory.createAdvertisementClient(networkService: networkService)
        return serviceFactory.createAdvertisementService(adClient: advertisementClient)
    }()
    
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
        let view = AdvertisementView()
        
        let viewController = AdvertisementsViewController(
            advertisementService: advertisementService,
            imageService: imageService,
            router: router,
            view: view
        )
        
        viewController.title = AppData.advertisementsVCTitle
        
        return viewController
    }
    
    func createAdvertisementDetailViewController(advertisementId: String, router: RouterProtocol) -> UIViewController {
        let view = AdvertisementDetailView()
        
        let viewController = AdvertisementDetailViewController(
            advertisementId: advertisementId,
            advertisementService: advertisementService,
            imageService: imageService,
            view: view
        )
        
        viewController.title = AppData.adDetailVCTitle
        
        return viewController
    }
}
