//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController : UIViewController {

    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Feed list"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()


    private let button: UIButton = {
            let button = UIButton()
            button.setTitle("View Post", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .gray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    

    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(button)


        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])
        NSLayoutConstraint.activate([
                   button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])

        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)

       }




    @objc func showPostController() {
            let detailController = PostViewController()
            navigationController?.pushViewController(detailController, animated: false)
        }


}
