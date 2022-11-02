//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Алексей Сердюк on 30.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//


import UIKit

class AppCoordinator : Coordinator {
    var child: [Coordinator] = []
    var transitionHandler : UITabBarController

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("App coordinator started")

        let feedCoordinator = ChildFeedCoordinator(transitionHandler: transitionHandler)
        child.append(feedCoordinator)
        feedCoordinator.start()

        let feedVC = FeedViewController()
        feedVC.coordinator = feedCoordinator
        let feedTabNavigationController = UINavigationController.init(rootViewController: feedVC)

        feedTabNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)

        // ---- //

        let loginCoordinator = ChildLoginCoordinator(transitionHandler: transitionHandler)
        child.append(loginCoordinator)
        loginCoordinator.start()

        let loginVC = LoginViewController()
        loginVC.coordinator = loginCoordinator
        let loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)


        loginTabNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

        transitionHandler.viewControllers = [feedTabNavigationController, loginTabNavigationController]

        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
    }



}
