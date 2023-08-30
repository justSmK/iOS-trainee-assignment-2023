//
//  AssemblyBuilderProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit.UIViewController

protocol AssemblyBuilderProtocol: AnyObject {
    func createInitialSetup() -> (UINavigationController, RouterProtocol)
    func createAdvertisementsViewController(router: RouterProtocol) -> UIViewController
    func createAdvertisementDetailViewController(advertisementId: String ,router: RouterProtocol) -> UIViewController
}
