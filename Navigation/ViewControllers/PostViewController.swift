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

    // создаем переменную для текста заголовка, в нее будет передаваться заголовок из FeedViewController
    var titlePost: String = ""

    // создаем заголовок страницы
    let titleLabel: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        // добавляем элемент на страницу и меняем заголовок на вновь пришедший
        view.addSubview(titleLabel)
        titleLabel.text = titlePost

        // добавляем расположение заголовка
        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])

        // создаем UIBarButtonItem с 1 контейнером по заданию
        let modal = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modal]
       }

        // функция для отображения InfoViewController в модальном окне
        @objc func showModal() {
            let popupViewController = InfoViewController()
            popupViewController.modalPresentationStyle = .fullScreen
            self.present(popupViewController, animated: true, completion: nil)
        }

}
