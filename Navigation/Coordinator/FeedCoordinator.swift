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

    weak var coordinator : AppCoordinator?

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("Feed coordinator started")
        showFeedScreen()
    }

    func showFeedScreen() {
        let viewController = FeedViewController()
        viewController.coordinator = self

        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.tabBarItem = TabBarItems[0]
        transitionHandler?.viewControllers = [navigationController]
    }

    func showPostScreen(navigationController : UINavigationController, title: String){
        let viewController = PostViewController()
        viewController.titlePost = title
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func showInfoScreen(sender : UIViewController){
        let popupViewController = InfoViewController()
        popupViewController.modalPresentationStyle = .fullScreen
        sender.present(popupViewController, animated: true, completion: nil)
    }
}

