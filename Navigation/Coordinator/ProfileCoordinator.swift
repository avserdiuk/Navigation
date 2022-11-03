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

    func showLoginScreen() {
        let controller = LoginViewController()
        controller.coordinator = self
        let profileTabNavigationController = UINavigationController.init(rootViewController: controller)
        profileTabNavigationController.tabBarItem = TabBarItems[1]
        transitionHandler?.viewControllers?.append(profileTabNavigationController)
    }

    func showProfileScreen(transitionHandler : UINavigationController){
        print("11")
        let profileViewController = ProfileViewController()
        //profileViewController.user_1 = userLogin.user
        transitionHandler.pushViewController(ProfileViewController(), animated: true)
    }

}
