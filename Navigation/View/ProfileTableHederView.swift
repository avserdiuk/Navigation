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

    enum StatusError : Error {
        case newStatusNotEntered
    }
    
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
    private lazy var setStatusButton: CustomButton = CustomButton(title: "Show status", cornerRadius: 14, maskToBounds: false)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addViews()
        addConstraints()
        addGestures()
        addNotifications()
        addBtnActions()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // функция с Result

    func changeStatus(newStatus status : String, complition: @escaping (Result<String, StatusError>)-> Void ) {

        if status == "" {
            complition(.failure(.newStatusNotEntered))
        } else {
            complition(.success(status))
        }
    }

    // функция смены статуса по нажатию кнопки
    func addBtnActions() {

        setStatusButton.btnAction = {

            self.changeStatus(newStatus: self.statusTextField.text ?? "") { result in
                switch result {
                case .success(let status):
                    self.statusLabel.text = status

                case .failure(let error):
                    print("Error: \(error)")
                }
            }
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

