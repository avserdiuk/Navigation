//
//  AppDelegate.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    let localNotificationsService = LocalNotificationsService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        localNotificationsService.registeForLatestUpdatesIfPossible()
        localNotificationsService.center.delegate = self

        
        FirebaseApp.configure()

        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("No authorized users")
            }
        }

        return true
    }
}


