//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

class FeedCoordinator : Coordinator {
    weak var transitionHandler: UITabBarController?

    var child: [Coordinator] = []

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("Feed coordinator started")

        showFeedScreen()
    }

    func showFeedScreen() {
        let feedNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        feedNavigationController.tabBarItem = TabBarItems[0]
        transitionHandler?.viewControllers = [feedNavigationController]
    }
}

