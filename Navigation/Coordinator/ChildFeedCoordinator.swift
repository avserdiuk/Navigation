//
//  ChildFeedCoordinator.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

class ChildFeedCoordinator : Coordinator {
    var transitionHandler: UITabBarController

    var child: [Coordinator] = []

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("Feed coordinator started")
    }
}

