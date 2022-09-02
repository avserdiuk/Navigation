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
    
    // создание обьекта по заданию
    var postTitle : PostFeed = PostFeed(title: "Post Title")
    
    // создаем кнопку для просмотра поста
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle(" View Post ", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        return button
    }()

    // создаем дополнительную кнопку
    private let button2: UIButton = {
        let button = UIButton()
        button.setTitle(" View Post ", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        return button
    }()

    // создаем стеквью
    private let stackViewButton : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.title = "Feed"

        // собираем и добавляем на экран
        addView()
        
        // проставляем привязки по расположению
        setConstraints()
        
    }

    func addView(){
        //обьединяем кнопки в стеквью
        stackViewButton.addArrangedSubview(button)
        stackViewButton.addArrangedSubview(button2)

        // отображаем все на экране
        view.addSubview(stackViewButton)
    }
    
    // функция для привязой элементов
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // функция обработки нажатия на кнопку
    @objc func showPostController() {
        let detailController = PostViewController()
        detailController.titlePost = postTitle.title
        navigationController?.pushViewController(detailController, animated: false)
    }
    
    
}
