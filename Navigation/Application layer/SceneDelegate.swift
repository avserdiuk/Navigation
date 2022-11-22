//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var feedTabNavigationController : UINavigationController!
    var mediaTabNavigationController : UINavigationController!
    var loginTabNavigationController : UINavigationController!

    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // создаем TabBarController
        let tabBarController = UITabBarController()
        
        // создаем 2 контейнера и присваиваем им нужные представления ViewController
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        mediaTabNavigationController = UINavigationController.init(rootViewController: MediaViewController())

        let loginVC = LoginViewController()
        //lvc.loginDelegate = LoginInspector() // делаем зависимость LoginViewController от LoginInspector (задание 1)
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector() // делаем зависимость LoginViewController от LoginInspector() (задание 2)
        loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)

        // заполняем таббар контроллер
        tabBarController.viewControllers = [feedTabNavigationController, mediaTabNavigationController, loginTabNavigationController]
        
        // cтилизация контейнеров
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)
        let item2 = UITabBarItem(title: "Media", image: UIImage(systemName: "play.square"), tag: 1)
        let item3 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
        
        feedTabNavigationController.tabBarItem = item1
        mediaTabNavigationController.tabBarItem = item2
        loginTabNavigationController.tabBarItem = item3
        
        // стилизация TabBar'a
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        
        // Запускаем созданный TabBarController как основное view представление
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window

        // Генерируем рандомно элемент и выполняем запрос с сеть
        appConfiguration = AppConfiguration.randomUrl()

        if let config = appConfiguration {
            NetworkManager.request(for: config)
        } else {
            print("❗️Bad url to request")
        }

    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

