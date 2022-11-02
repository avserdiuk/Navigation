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
    let alertController = UIAlertController(title: "TitlPfujke", message: "Test Message", preferredStyle: .alert)

    // создаем кастомные кнопки для закрытия модального кона
    private lazy var button: CustomButton = CustomButton(title: " Close ")
    private lazy var buttonAlert: CustomButton = CustomButton(title: " Alert ")


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground

        // проставляем элементы на экране
        view.addSubview(button)
        view.addSubview(buttonAlert)

        addConstraints()
        addBtnActions()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func addBtnActions(){
        button.btnAction = {
            self.dismiss(animated: true, completion: nil)
        }
        
        buttonAlert.btnAction = {
            self.present(self.alertController, animated: true, completion: nil)
        }
    }






}
