//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Алексей Сердюк on 16.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

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
        img.isUserInteractionEnabled = true
        return img
    }()
    
    // создаем лейб для имени
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // создаем лейб для статуса
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
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

    // функция установки пользоваля по полям
    func setup(user : User){
        fullNameLabel.text = user.fio
        statusLabel.text = user.status
        avatarImageView.image = user.avatar
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

        // Новая реализация через SnapKit

        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(100)
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(16)
                }

        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(self.snp.left).offset(140)
        }

        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(54)
            make.left.equalTo(self.snp.left).offset(140)
        }

        statusTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.equalTo(self.snp.left).offset(140)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(40)
        }

        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(self.snp.top).offset(132)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }
        
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

