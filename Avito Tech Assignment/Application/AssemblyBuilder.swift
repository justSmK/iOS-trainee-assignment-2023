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
        
        let imageService = ImageService()
        
        let view = AdvertisementView()
        
        let viewController = AdvertisementsViewController(networkService: networkService, imageService: imageService, view: view)
        
        return viewController
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
