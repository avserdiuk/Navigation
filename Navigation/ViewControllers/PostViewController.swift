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

    var titlePost: String = ""
    // let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert) ДЛЯ СЛЕД ЗАДАНИЯ

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

       // alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                   //print("alert")
               // })) ДЛЯ СЛЕД ЗАДАНИЯ

        view.addSubview(titleLabel)
        titleLabel.text = titlePost

        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]



       }

        @objc func addTapped() {
           // self.present(alertController, animated: true, completion: nil) ДЛЯ СЛЕД ЗАДАНИЯ

            let popupViewController = InfoViewController()
            popupViewController.modalPresentationStyle = .fullScreen
            self.present(popupViewController, animated: true, completion: nil)
        }

}
