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
    var postTitle : Post = Post(title: "Post Title")
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.title = "Feed"
        
        // отображаем все на экране
        view.addSubview(button)
        
        // проставляем привязки по расположению
        setConstraints()
        
    }
    
    // функция для привязой элементов
    func setConstraints(){
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
