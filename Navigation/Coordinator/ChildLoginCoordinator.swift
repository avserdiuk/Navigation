//
//  ChildLoginCoordinator.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

class ChildLoginCoordinator : Coordinator {
    var transitionHandler: UITabBarController

    var child: [Coordinator] = []

    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }

    func start(){
        print("Profile coordinator started")
    }
}

