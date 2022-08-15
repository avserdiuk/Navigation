//
//  PostViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 15.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class PostViewController : UIViewController {

    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Post"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan

        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])

       }
}
