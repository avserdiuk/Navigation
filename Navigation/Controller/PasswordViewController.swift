//
//  PasswordViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 07.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess

class PasswordViewController : UIViewController {

    let keychain = Keychain(service: "navigator")
    var password : String = ""

    var status : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "status")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "status")
        }
    }

    var tryCount : Int {
        get {
            return UserDefaults.standard.integer(forKey: "tryCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "tryCount")
        }
    }

    private lazy var textInputField : UITextField = {
        let textInputField = UITextField()
        textInputField.translatesAutoresizingMaskIntoConstraints = false
        textInputField.layer.borderWidth = 1
        return textInputField
    }()

    private lazy var button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("create password", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Password Form"

        view.addSubview(textInputField)
        view.addSubview(button)

        NSLayoutConstraint.activate([

            textInputField.heightAnchor.constraint(equalToConstant: 44),
            textInputField.widthAnchor.constraint(equalToConstant: 200),
            textInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textInputField.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textInputField.bottomAnchor, constant: 30),
            
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        //        status = false
        //        tryCount = 0
        //        keychain["password"] = ""

        if status == false {
            button.setTitle("create password", for: .normal)
        } else {
            button.setTitle("enter password", for: .normal)
        }

    }

    @objc
    func action(){

        if status == false {
            if tryCount == 1 {

                if textInputField.text == password {
                    textInputField.text = .none
                    button.setTitle("success!", for: .normal)
                    button.backgroundColor = .systemGreen
                    keychain["password"] = password
                    status = true

                    print("success")

                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                        self.button.setTitle("enter password", for: .normal)
                        self.button.backgroundColor = .systemBlue
                    }
                } else {
                    button.setTitle("create password", for: .normal)
                    tryCount = 0
                    textInputField.text = .none

                    print("wrong 2nd pass")

                    button.setTitle("wrong 2nd pass", for: .normal)
                    button.backgroundColor = .systemRed

                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                        self.button.setTitle("enter password", for: .normal)
                        self.button.backgroundColor = .systemBlue
                    }
                }

            } else if tryCount == 0 {
                password = textInputField.text!
                textInputField.text = .none
                button.setTitle("repeat password", for: .normal)
                tryCount += 1
            }
        } else {
            print("checking password")

            let token = try? keychain.get("password")
            if textInputField.text == token! {
                print("succes")

                button.setTitle("success!", for: .normal)
                button.backgroundColor = .systemGreen

                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    print("push view")
                    let tabBarController = UITabBarController()
                    var fileTabNavigationController : UINavigationController!
                    var settingsTabNavigationController : UINavigationController!

                    let url = FileManagerService().documentsDirectoryUrl
                    let fileVC = FileViewController()
                    fileVC.title = "File Manager"
                    fileVC.content = FileManagerService().contentsOfDirectory(url)
                    fileTabNavigationController = UINavigationController.init(rootViewController: fileVC)
                    settingsTabNavigationController = UINavigationController.init(rootViewController: SettingViewController())

                    let item4 = UITabBarItem(title: "File", image: UIImage(systemName: "folder.fill"), tag: 3)
                    let item5 = UITabBarItem(title: "Settings", image: UIImage(systemName: "slider.horizontal.3"), tag: 4)

                    fileTabNavigationController.tabBarItem = item4
                    settingsTabNavigationController.tabBarItem = item5

                    tabBarController.viewControllers = [fileTabNavigationController, settingsTabNavigationController]

                    self.navigationController?.pushViewController(tabBarController, animated: true)
                }

            } else {
                textInputField.text = .none
                print("wrong password")

                button.setTitle("wrong passord", for: .normal)
                button.backgroundColor = .systemRed

                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    self.button.setTitle("enter password", for: .normal)
                    self.button.backgroundColor = .systemBlue
                }
            }
        }

    }
}
