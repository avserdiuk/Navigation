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
    weak var transitionHandler : UITabBarController?

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("App coordinator started \n")

        startFeedCoordinator()
        startLoginCoordinator()

    }

    func startFeedCoordinator() {
        let feedCoordinator = FeedCoordinator(transitionHandler: transitionHandler!)
        child.append(feedCoordinator)
        feedCoordinator.coordinator = self
        feedCoordinator.start()
    }

    func startLoginCoordinator() {
        let profileCoordinator = ProfileCoordinator(transitionHandler: transitionHandler!)
        child.append(profileCoordinator)
        profileCoordinator.coordinator = self
        profileCoordinator.start()
    }

}
