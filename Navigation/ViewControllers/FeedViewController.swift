//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

// создание структуры по заданию
struct Post {
    var title : String
}

class FeedViewController : UIViewController {

    // создание обьекта по заданию
    var postTitle = Post(title: "Post Title")

    // создаем UILabel для заголовка
    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Feed"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    // создаем кнопку для просмотра поста
    private let button: UIButton = {
            let button = UIButton()
            button.setTitle(" View Post ", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(UIColor.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    

    override func viewDidLoad() {
           super.viewDidLoad()

            view.backgroundColor = .systemBackground

            // отображаем все на экране
            view.addSubview(titleLabel)
            view.addSubview(button)

            // ставим таргет на кнопку
            button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)

            // проставляем привязки по расположению
            setConstraints()

       }

    // функция для привязой элементов
    func setConstraints(){
        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                   titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               ])
        NSLayoutConstraint.activate([
                   button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])
    }

    // функция обработки нажатия на кнопку
    @objc func showPostController() {
        let detailController = PostViewController()
        detailController.titlePost = postTitle.title
        navigationController?.pushViewController(detailController, animated: false)
        }


}
