//
//  TabBarModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

let TabBarItems : [UITabBarItem] = [
    UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0),
    UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
]

var feedNavigationController : UINavigationController {
    let controller = UINavigationController.init(rootViewController: FeedViewController())
    controller.tabBarItem = TabBarItems[0]
    return controller
}

var profileNavigationController : UINavigationController {
    let controller = UINavigationController.init(rootViewController: LoginViewController())
    controller.tabBarItem = TabBarItems[1]
    return controller
}
