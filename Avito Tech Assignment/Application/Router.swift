//
//  Router.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail()
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController? = nil, assemblyBuilder: AssemblyBuilderProtocol? = nil) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController {
            guard let mainViewController = assemblyBuilder?.createAdvertisementsViewController(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail() {
        
    }
    
    func popToRoot() {
        if let navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    
    
}
