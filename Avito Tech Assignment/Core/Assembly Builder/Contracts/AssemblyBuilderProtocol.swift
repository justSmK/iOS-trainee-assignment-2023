//
//  AssemblyBuilderProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit.UIViewController

protocol AssemblyBuilderProtocol: AnyObject {
    func createInitialSetup() -> (UINavigationController, Router)
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController
    func createDetailModule() -> UIViewController
}
