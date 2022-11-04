//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

class ProfileCoordinator : Coordinator {
    weak var transitionHandler: UITabBarController?

    var child: [Coordinator] = []

    weak var coordinator : AppCoordinator?

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }
    
    func start(){
        print("Profile coordinator started")
        showLoginScreen()
    }

    func showLoginScreen(){
        let viewController = LoginViewController()
        viewController.coordinator = self

        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.tabBarItem = TabBarItems[1]
        transitionHandler?.viewControllers?.append(navigationController)
    }

    func showProfileScreen(transitionHandler : UINavigationController, user : AppUser){
        let controller = ProfileViewController()
        controller.user_1 = user.user
        transitionHandler.pushViewController(controller, animated: true)
    }

}

