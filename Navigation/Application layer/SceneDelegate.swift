//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator : AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        let transitionHandler = UITabBarController()

        coordinator = AppCoordinator.init(transitionHandler: transitionHandler)
        coordinator?.start()

        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        
        window.rootViewController = transitionHandler
        window.makeKeyAndVisible()

        self.window = window

        
    }
    
}

