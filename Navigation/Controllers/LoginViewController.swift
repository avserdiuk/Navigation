//
//  LogInViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 30.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//


import Foundation
import UIKit

class LoginViewController : UIViewController {

    // создаем алерт c заголовок и сообщением
    let alertController = UIAlertController(title: "Ошибка!", message: "Не правильный логин", preferredStyle: .alert)

    // создаем скролвью
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // создаем лого
    private lazy var logoImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    // создаем текстовое поля для ввода email
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.font = UIFont(name: "system", size: 16.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()

    // создаем разделитель между текстовыми полями (для соответствия макету)
    private lazy var horizontalLine : UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = .lightGray
        return horizontalLine
    }()

    // создаем текстовое поля для ввода password
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "system", size: 16.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()

    // создаем стеквью для полей ввода
    private lazy var stackViewTextFields : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // добавляем кнопку Login
    //TODO: добавить изменение прозрачности при изменении состояния
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.navigationController?.navigationBar.isHidden = true

        addViews()
        addConstraints()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
            print("message in console")
        }))
    }

    // ------------------------------------------------------------------------------------------------

    // обработка открытия и закрытия клавиатуры
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // для проверки изменения прозрачности кнопки при изменениии состояния снопки

        //        loginButton.isHighlighted = true
        //        loginButton.isSelected = true
        //        loginButton.isEnabled = false

        if !loginButton.isEnabled || loginButton.isSelected || loginButton.isHighlighted { loginButton.alpha = 0.8 }

        // наблюдаем за уведомлениями об появлении или исчезнавении клавиатуры

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    // функция для обработки тапа и сокрытия клавиатуры
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    // функция когда скрывает клавиатура, тут мы все считаем и определяем перекрытие
    @objc func didShowKeyboard(_ notification: Notification){
        print("show keyboard")

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            // считаем нужную точку и проверяем перекрывает ли клавиатура кнопку

            let loginButtonBottomPointY = self.loginButton.frame.origin.y + loginButton.frame.height

            let keyboardOriginY = self.view.frame.height - keyboardHeight

            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 32
            : 0

            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    // функции сокрытия клавиатуры
    @objc func didHideKeyboard(_ notification: Notification){
        self.forcedHidingKeyboard()
    }
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    // ------------------------------------------------------------------------------------------------

    // функция нажатия логин
    @objc func login() {

        let userLogin = emailTextField.text

        let curUser = CurrentUserService(user: User(login: "login123", fio: "22", status: "33"))

        if curUser.checkLogin(login: userLogin!) != nil {
            let profileViewController = ProfileViewController()
            profileViewController.user_1 = curUser.user
            navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func addViews(){

        view.addSubview(scrollView)

        scrollView.addSubview(logoImageView)

        //обьединяем кнопки в стеквью
        stackViewTextFields.addArrangedSubview(emailTextField)
        stackViewTextFields.addArrangedSubview(horizontalLine)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        scrollView.addSubview(stackViewTextFields)

        scrollView.addSubview(loginButton)
    }

    func addConstraints(){
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),

            stackViewTextFields.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackViewTextFields.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            stackViewTextFields.heightAnchor.constraint(equalToConstant: 100),

            emailTextField.heightAnchor.constraint(equalToConstant: 49.75),
            emailTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            emailTextField.leftAnchor.constraint(equalTo: stackViewTextFields.leftAnchor, constant: 0),

            horizontalLine.heightAnchor.constraint(equalToConstant: 0.5),
            horizontalLine.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            horizontalLine.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),

            passwordTextField.heightAnchor.constraint(equalToConstant: 49.75),
            passwordTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: stackViewTextFields.leftAnchor, constant: 0),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
        ])
    }
}

