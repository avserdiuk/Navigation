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

    // создаем UILabel для заголовка
    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Profile"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    override func viewDidLoad() {
           super.viewDidLoad()
            view.backgroundColor = .systemBackground

            // добавляем на экран
            view.addSubview(titleLabel)

            // проставляем привязки для заголовка (можно вынести в функцию, как например в FeedViewController)
            NSLayoutConstraint.activate([
                       titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                       titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                   ])

       }
}
