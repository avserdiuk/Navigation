//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Алексей Сердюк on 16.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileHeaderView : UITableViewHeaderFooterView {
    
    var statusText : String = ""
    
    // создаем аватарку
    private let avatarImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatarImage")
        img.layer.cornerRadius = 50
        img.layer.masksToBounds = true
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()
    
    // создаем лейб для имени
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // создаем лейб для статуса
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // создаем текстовое поля для ввода нового статуса
    private lazy var statusTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your status..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    // создаем кнопку смены статуса
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        //        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        //        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        //        button.layer.shadowOpacity = 0.7
        //        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addViews()
        addConstraints()
        addGestures()
        addNotifications()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // функция смены статуса по нажатию кнопки
    @objc func buttonPressed() {
        if let text = statusLabel.text {
            print(text)
        }
        if statusText != "" {
            statusLabel.text = statusText
        }
    }
    
    // функция сохранения значения из текстового поля
    @objc func statusTextChanged(_ textField: UITextField){
        if let text = textField.text {
            statusText = text
        }
    }

    func setup(user : User){
        fullNameLabel.text = user.fio
        statusLabel.text = user.status
    }
    
    // добавляем вью
    func addViews(){
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }
    
    // добавляем привязки
    func addConstraints(){
        NSLayoutConstraint.activate([

            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            
            statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 54),
            statusLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            
            statusTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            statusTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 132),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }


    // РАБОТА С АВАТАРКОЙ ПРИ КЛИКЕ //

    func addGestures(){
        // ставим гестуру на клик аватарки
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    func addNotifications(){
        // ловим уведомлении о закрытии
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didClickClose(notification:)),
                                               name: Notification.Name("closeClick!"),
                                               object: nil)
    }

    // при клике на авау делаем вот это:
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer){
        // кидаем уведомление о клике на аву
        NotificationCenter.default.post(name: Notification.Name("avaClick!"), object: nil)

        // и скрываем первоначальную аватарку
        avatarImageView.isHidden = true
    }

    // если поймали уведомление то выполянем вот это:
    @objc func didClickClose(notification: Notification) {
        avatarImageView.isHidden = false
    }
    
}

