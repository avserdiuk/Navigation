//
//  AppDelegate.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("No authorized users")
            } else {
                if let user = user {
                    let uid = user.uid
                    let email = user.email
                    let photoURL = user.photoURL
                    var multiFactorString = "MultiFactor: "
                    for info in user.multiFactor.enrolledFactors {
                        multiFactorString += info.displayName ?? "[DispayName]"
                        multiFactorString += " "
                    }
                    // ...
//                    print("Authorized user: ")
//                    print(uid, email, photoURL)
                }
            }

        }

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

    }
    
    
}

