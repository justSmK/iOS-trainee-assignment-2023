//
//  AssemblyBuilder.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AssemblyBuilder {

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
}

// MARK: - AssemblyBuilderProtocol

extension AssemblyBuilder: AssemblyBuilderProtocol {
    func createInitialSetup() -> (UINavigationController, RouterProtocol) {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        return (navigationController, router)
    }
    
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController {
        
        let view = AdvertisementsViewController()
        view.title = AppData.advertisementsVCTitle
        
        let presenter = AdvertisementPresenter(
            view: view,
            advertisementService: advertisementService,
            imageService: imageService,
            router: router
        )
        view.presenter = presenter
        
        return view
    }
    
    func createAdvertisementDetailViewController(advertisementId: String, router: RouterProtocol) -> UIViewController {
        
        let view = AdvertisementDetailViewController()
        view.title = AppData.adDetailVCTitle
        
        let presenter = AdvertisementDetailPresenter(
            view: view,
            advertisementId: advertisementId,
            advertisementService: advertisementService,
            imageService: imageService
        )
            
        view.presenter = presenter
        
        return view
    }
}
