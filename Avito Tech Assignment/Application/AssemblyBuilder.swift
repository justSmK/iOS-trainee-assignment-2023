//
//  AssemblyBuilder.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController
    func createDetailModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController {
        let configuration = URLSessionConfiguration.default
        configuration.multipathServiceType = .aggregate
        let urlSession = URLSession(configuration: configuration)
        
        let networkService = NetworkService(session: urlSession)
        
        let imageClient = ImageAPIClient(networkService: networkService)
        let imageService = ImageService(imageClient: imageClient)
        
        let advertisementClient = AdvertisementAPIClient(networkService: networkService)
        let advertisementService = AdvertisementService(advertisementClient: advertisementClient)
        
        let view = AdvertisementView()
        
        let viewController = AdvertisementsViewController(advertisementService: advertisementService, imageService: imageService, view: view)
//        let viewController = AdvertisementsViewController(networkService: networkService, imageService: imageService, view: view)
        
        return viewController
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
