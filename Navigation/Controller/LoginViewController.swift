//
//  LogInViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 30.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import RealmSwift


class LoginViewController : UIViewController {

#if DEBUG
    var userLogin : TestUserService?
#else
    var userLogin : CurrentUserService?
#endif

    enum AuthorisationErrors: Error {
        case userNotFound
    }

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
        textField.text = "test123@test.ru"
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
        horizontalLine.backgroundColor = colorBorder
        return horizontalLine
    }()

    // создаем текстовое поля для ввода password
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "123123"
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
        stackView.backgroundColor = colorSecondaryBackground
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = colorBorder.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // добавляем кнопку Login
    private lazy var loginButton: CustomButton = CustomButton(title: "Log In", backgroundColor:  UIColor(patternImage: UIImage(named: "blue_pixel.png")!), cornerRadius: 10)

    private lazy var loginButtonBiometry: CustomButton = CustomButton(title: " Log In with ", backgroundColor:  UIColor(patternImage: UIImage(named: "blue_pixel.png")!), cornerRadius: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorMainBackground
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

        let type = LocalAuthorizationService().canEvaluate()

        if type == 2 {
            loginButtonBiometry.setImage(UIImage(systemName: "faceid"),for: .normal)
        } else if type == 1 {
            loginButtonBiometry.setImage(UIImage(systemName: "touchid"),for: .normal)
        } else {
            loginButtonBiometry.isHidden = true
        }

#if DEBUG
        userLogin = TestUserService(user: User(fio: "Ivan Testov", avatar: UIImage(named: "avatarTest") ?? UIImage(), status: "Testing app..."))
#else
        userLogin = CurrentUserService(user: User(fio: "Prod Petrovich", avatar: UIImage(named: "avatarProd") ?? UIImage(), status: "Go to AppStore! (-_-)"))
#endif


        let realm = try! Realm()
        let users = realm.objects(RealmUser.self)

        let user = users.where {
            $0.login == UserDefaults.standard.string(forKey: "userLogin")
        }

        if user.isEmpty {
            print("user not found")
        } else {
            if user[0].lastAuth != nil {
                let profileViewController = ProfileViewController()
                profileViewController.user_1 = userLogin!.user
                self.navigationController?.pushViewController(profileViewController, animated: true)
            }
        }

        print("--> \(user)")


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
        //print("show keyboard")

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

    func checkingAccess(_ login : String, _ password : String) throws {

        if (self.loginDelegate?.check(self, login: login, password: password)) == false {
            throw AuthorisationErrors.userNotFound
        }

    }

    func alertBadPassword(message : String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    func alertSuccess(message : String){
        let alert = UIAlertController(title: "Done!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thx!", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    func alertBadLogin(message : String, complition: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Register new user", style: .default) { action in
            complition(true)
        })
        alert.addAction(UIAlertAction(title: "Try again", style: .default))
        self.present(alert, animated: true, completion: nil)
    }


    // функция нажатия логин
    func addBtnActions() {

        func auth(){

            // берем то что вводит пользователь в поле "email"
            let enteredUserLogin = self.emailTextField.text!
            let enteredUserPassword = self.passwordTextField.text!


            CheckerService().checkCredentials(email: enteredUserLogin, password: enteredUserPassword) { result in
                if result == "Success authorization" {

//                    let realm = try! Realm()
//                    let users = realm.objects(RealmUser.self)
//
//
//                    let user = users.where {
//                        $0.login == enteredUserLogin && $0.password == enteredUserPassword
//                    }
//
//                    print(user)
//                    try! realm.write {
//                        user[0].lastAuth = NSDate().timeIntervalSince1970
//                        UserDefaults.standard.set(user[0].login, forKey: "userLogin")
//                    }
//                    print(user)

                    let profileViewController = ProfileViewController()
                    profileViewController.user_1 = self.userLogin!.user
                    self.navigationController?.pushViewController(profileViewController, animated: true)



                } else if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.alertBadLogin(message: result) { result in
                        CheckerService().signUp(email: enteredUserLogin, password: enteredUserPassword) { result in
                            if result == "Success registration" {
                                self.alertSuccess(message: result)


                                let realm = try! Realm()
                                let newUser = RealmUser(login: enteredUserLogin, password: enteredUserPassword)

                                //print("❗️\(realm)")
                                try! realm.write {
                                    realm.add(newUser)
                                    //print("❗️❗️\(realm)")
                                }


                            } else {
                                self.alertBadPassword(message: result)
                            }
                        }
                    }
                } else {
                    self.alertBadPassword(message: result)
                }
            }


            /*
             // если мы в дебаг версии то меняем цвет фона, иначе оставляем все как было
             #if DEBUG
             let userLogin = TestUserService(user: User(fio: "Ivan Testov", avatar: UIImage(named: "avatarTest") ?? UIImage(), status: "Testing app..."))
             #else
             let userLogin = CurrentUserService(user: User(fio: "Prod Petrovich", avatar: UIImage(named: "avatarProd") ?? UIImage(), status: "Go to AppStore! (-_-)"))
             #endif


             do {
             try self.checkingAccess(enteredUserLogin!, enteredUserPassword!)

             let profileViewController = ProfileViewController()
             profileViewController.user_1 = userLogin.user
             self.navigationController?.pushViewController(profileViewController, animated: true)
             print("No Error")
             }

             catch AuthorisationErrors.userNotFound {
             self.present(self.alertController, animated: true, completion: nil)
             print("Error: user not found")
             }
             */
            // проверка введеного логика на соответствие. Если все ок - переходим на другой контроллер, если нет - ошибка!

            //            if self.loginDelegate?.check(self, login: enteredUserLogin ?? "", password: enteredUserPassword ?? "") == true {
            //                let profileViewController = ProfileViewController()
            //                profileViewController.user_1 = userLogin.user
            //                self.navigationController?.pushViewController(profileViewController, animated: true)
            //            } else {
            //                self.present(self.alertController, animated: true, completion: nil)
            //            }
        }

        loginButtonBiometry.btnAction = {
                    LocalAuthorizationService().authorizeIfPossible { Bool, Error in
                        if Bool {
                            auth()
                        }
                    }
        }

        loginButton.btnAction =  {
            auth()
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
        scrollView.addSubview(loginButtonBiometry)
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

            loginButtonBiometry.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            loginButtonBiometry.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            loginButtonBiometry.heightAnchor.constraint(equalToConstant: 50),
            loginButtonBiometry.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
        ])
    }
}

