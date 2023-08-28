//
//  SceneDelegate.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let assemblyBuilder = AssemblyBuilder()
        let (navigationController, router) = assemblyBuilder.createInitialSetup()
        router.initialViewController()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

