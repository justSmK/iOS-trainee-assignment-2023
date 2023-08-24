//
//  AssemblyBuilder.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainVC(router: RouterProtocol) -> UIViewController
    func createDetailModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainVC(router: RouterProtocol) -> UIViewController {
        
        let networkService = NetworkService()
        let viewController = ViewController(networkService: networkService)
        
        return viewController
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
