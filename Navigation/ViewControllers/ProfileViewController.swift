//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {

    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Profile"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .gray

        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])

       }
}
