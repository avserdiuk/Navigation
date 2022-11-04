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
    
    var coordinator : FeedCoordinator?
    
    // создание обьекта по заданию
    var postTitle : PostFeed = PostFeed(title: "Post Title")

    // создаем КАСТОМНЫЕ кнопки
    private lazy var button1 = CustomButton(title: " My custom button 1 ")
    private lazy var button2 = CustomButton(title: " My custom button 2 ")

    // создаем новое поле ввода и кнопку
    private lazy var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your password.."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    private lazy var checkGuessButton = CustomButton(title: " checkGuessButton ")
    private lazy var resultButton = CustomButton(title: " resultButton ")

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

        // проставляем действия на кнопки
        addBtnActions()
        
    }

    func addView(){
        //обьединяем кнопки в стеквью
        stackViewButton.addArrangedSubview(button1)
        stackViewButton.addArrangedSubview(button2)
        stackViewButton.addArrangedSubview(textField)
        stackViewButton.addArrangedSubview(checkGuessButton)
        stackViewButton.addArrangedSubview(resultButton)

        // отображаем все на экране
        view.addSubview(stackViewButton)
    }
    
    // функция для привязой элементов
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // функция передачи действия на кнопки
    func addBtnActions(){
        button1.btnAction = {
//            let detailController = PostViewController()
//            detailController.titlePost = self.postTitle.title
//            self.navigationController?.pushViewController(detailController, animated: false)

            self.coordinator?.showPostScreen(navigationController: self.navigationController!, title: self.postTitle.title)
        }

        // т.к. действия одинаковые, что бы не дублировать код =)
        button2.btnAction = button1.btnAction

        // кнопка проверки пароля
        checkGuessButton.btnAction = {
            let input = self.textField.text ?? ""
            let result : Bool = FeedModel().check(word: input)
            if result == true {
                self.resultButton.backgroundColor = .green
                self.resultButton.setTitle(" True ", for: .normal)
            } else {
                self.resultButton.backgroundColor = .red
                self.resultButton.setTitle(" False ", for: .normal)
            }
        }
    }
}
