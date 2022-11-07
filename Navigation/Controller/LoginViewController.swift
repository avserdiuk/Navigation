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

    // добавляем делегата
    var loginDelegate : LoginViewControllerDelegate?

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
    private lazy var loginButton: CustomButton = CustomButton(title: "Log In", backgroundColor:  UIColor(patternImage: UIImage(named: "blue_pixel.png")!), cornerRadius: 10)

    private lazy var generatePasswordButton: CustomButton = CustomButton(title: "Generate password (-_-)", backgroundColor:  UIColor(patternImage: UIImage(named: "blue_pixel.png")!), cornerRadius: 10)

    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.navigationController?.navigationBar.isHidden = true

        addViews()
        addConstraints()

        addBtnActions()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "Повторить", style: .default))
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
    func addBtnActions() {

        loginButton.btnAction = {

            // берем то что вводит пользователь в поле "email"
            let enteredUserLogin = self.emailTextField.text
            let enteredUserPassword = self.passwordTextField.text

            // если мы в дебаг версии то меняем цвет фона, иначе оставляем все как было
#if DEBUG
            let userLogin = TestUserService(user: User(fio: "Ivan Testov", avatar: UIImage(named: "avatarTest") ?? UIImage(), status: "Testing app..."))
#else
            let userLogin = CurrentUserService(user: User(fio: "Prod Petrovich", avatar: UIImage(named: "avatarProd") ?? UIImage(), status: "Go to AppStore! (-_-)"))
#endif

            // проверка введеного логика на соответствие. Если все ок - переходим на другой контроллер, если нет - ошибка!

            if self.loginDelegate?.check(self, login: enteredUserLogin ?? "", password: enteredUserPassword ?? "") == true {
                let profileViewController = ProfileViewController()
                profileViewController.user_1 = userLogin.user
                self.navigationController?.pushViewController(profileViewController, animated: true)
            } else {
                self.present(self.alertController, animated: true, completion: nil)
            }

        }

        generatePasswordButton.btnAction = {
            self.passwordTextField.text = nil
            self.generatePasswordButton.isEnabled = false
            self.generatePasswordButton.backgroundColor = .systemGray

            self.activityIndicator.startAnimating()

            var password : String {
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                return String((0..<3).map{ _ in letters.randomElement()! })
            }

            DispatchQueue.global(qos: .userInitiated).async {
                self.bruteForce(passwordToUnlock: password)
            }
        }
    }

    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }

        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.passwordTextField.isSecureTextEntry = false
            self.passwordTextField.text = password
            self.generatePasswordButton.isEnabled = true
            self.generatePasswordButton.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
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
        scrollView.addSubview(generatePasswordButton)
        scrollView.addSubview(activityIndicator)
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

            generatePasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            generatePasswordButton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            generatePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            generatePasswordButton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),

            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -16),
        ])
    }

}

