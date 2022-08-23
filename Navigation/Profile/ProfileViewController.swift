//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {

    // создаем вью с элементами профиля
    let profileView: UIView = {
        let view = ProfileHeaderView()

        //добавляем обводку для визуальной проверки ДЗ, что выполнены условия отступов, высоты и привязки
        //view.layer.borderWidth = 1
        //view.layer.borderColor = UIColor.black.cgColor

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // добавляем новую кнопку по заданию
    private let newButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Button", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        self.title = "Profile"
        
        view.addSubview(profileView)
        view.addSubview(newButton)

        addConstrains()
        

    }

    // функция тестирования кнопки что она видна, нажимается
    @objc func pressButton() {
        print("test button")
    }

    // описываем все констрейнты
    func addConstrains(){
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileView.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 0),
            profileView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220),

            newButton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 0),
            newButton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            newButton.bottomAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            newButton.widthAnchor.constraint(equalToConstant: 340),
            newButton.heightAnchor.constraint(equalToConstant: 50),
         ])
    }

}
