//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 15.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController : UIViewController{

    // создаем алерт c заголовок и сообщением
    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

    // создаем кнопку для закрытия модального кона
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPostController), for: .touchUpInside)
        return button
    }()

    // создаем кнопку для показа алерта
    private lazy var buttonAlert: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground

        // проставляем элементы на экране
        view.addSubview(button)
        view.addSubview(buttonAlert)

        addConstraints()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("message in console")
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("message in console2")
        }))
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // функция закрытия модального кона
    @objc func showPostController() {
        self.dismiss(animated: true, completion: nil)
    }
    // функция показа алерта
    @objc func showAlert() {
        self.present(alertController, animated: true, completion: nil)
    }





}
