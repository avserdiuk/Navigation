//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 15.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController : UIViewController{

    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

    private let button: UIButton = {
            let button = UIButton()
            button.setTitle("Close", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .gray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    private let buttonAlert: UIButton = {
            let button = UIButton()
            button.setTitle("Alert", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .gray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .green

        view.addSubview(button)
        view.addSubview(buttonAlert)

        NSLayoutConstraint.activate([
                   button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])
        NSLayoutConstraint.activate([
                buttonAlert.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])

        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)

        buttonAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    print("message in console")
                }))

        alertController.addAction(UIAlertAction(title: "OK2", style: .default, handler: { _ in
                    print("message in console2")
                }))

        

       }




    @objc func showPostController() {
        self.dismiss(animated: true, completion: nil)
        }

    @objc func showAlert() {
        self.present(alertController, animated: true, completion: nil)
        }





}
