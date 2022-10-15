//
//  UserModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 13.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

//Смоделируем случай, когда в схеме Debug, которая была создана по результатам первой домашней работы, вводится тестовый логин.
//Добавьте новый класс TestUserService, который также поддерживает протокол UserService. Класс должен хранить объект класса User с тестовыми данными и возвращать его в реализации протокола.
//С помощью флага компиляции #DEBUG сделайте проверку текущей схемы и в зависимости от сборки Release или Debug при проверке логина передавайте в ProfileViewController пользователя, полученного через сервис CurrentUserService или TestUserService. Используйте возможности полиморфного поведения объектов,обеспечиваемых протокольно-ориентированным программированием.
//Проверьте, что теперь в профиль передается корректная информация в зависимости от сборки Release или Debug.

import Foundation
import UIKit

protocol UserService {
    func checkLogin (login : String) -> User?
}

class TestUserService : UserService {
    let user : User

    func checkLogin(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }

    init(user: User) {
        self.user = user
    }
}

class CurrentUserService  : UserService {
    let user : User

    func checkLogin(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }

    init(user: User) {
        self.user = user
    }
}

class User {
    let login : String
    let fio : String
    let avatar : UIImage
    let status : String

    init(login: String, fio: String, avatar: UIImage, status: String) {
        self.login = login
        self.fio = fio
        self.avatar = avatar
        self.status = status
    }


}