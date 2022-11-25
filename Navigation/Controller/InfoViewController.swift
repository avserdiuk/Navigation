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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tatuinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground

        // проставляем элементы на экране
        view.addSubview(button)
        view.addSubview(buttonAlert)
        view.addSubview(titleLabel)
        view.addSubview(tatuinLabel)

        addConstraints()
        addBtnActions()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        alertController.addAction(UIAlertAction(title: "Close", style: .default))

        titleLabel.text = user.title

    }


    func addConstraints(){
        NSLayoutConstraint.activate([
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tatuinLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tatuinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
