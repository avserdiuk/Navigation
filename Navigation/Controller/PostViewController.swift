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

    var coordinator : FeedCoordinator?
    
    // Создаем переменную для текста заголовка, в нее будет передаваться заголовок из FeedViewController
    var titlePost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        // Меняем заголовок на вновь пришедший
        self.title = titlePost
        
        // Создаем UIBarButtonItem с 1 контейнером по заданию
        let modal = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modal]
    }
    
    // Функция для отображения InfoViewController в модальном окне
    @objc func showModal() {
        coordinator?.showInfoScreen(sender: self)
    }
}
