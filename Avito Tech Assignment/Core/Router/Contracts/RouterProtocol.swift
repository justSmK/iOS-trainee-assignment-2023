//
//  RouterProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit.UINavigationController

protocol RouterMain: AnyObject {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showAdvertisementDetails(advertisementId: String)
    func popToRoot()
}
