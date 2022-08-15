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


    private let button: UIButton = {
            let button = UIButton()
            button.setTitle("Close", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .gray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .green

        view.addSubview(button)

        NSLayoutConstraint.activate([
                   button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])

        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)

       }




    @objc func showPostController() {
        self.dismiss(animated: true, completion: nil)
        }





}
