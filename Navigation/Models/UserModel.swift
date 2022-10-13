//
//  UserModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 13.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

//Добавьте новый класс User для хранения информации о пользователе со свойствами: логин, полное имя, аватар, статус. Типы для свойств - String, за исключением аватара, который должен иметь тип UIImage.
//Добавьте новый протокол UserService с функцией, которая в качестве аргумента принимает логин и возвращает объект класса User?. То есть, в случае неверного логина, пользователь не будет авторизован.

//Добавьте новый класс CurrentUserService, который поддерживает протокол UserService. Класс должен хранить объект класса User и возвращать его в функции, реализующей протокол, если, конечно, переданный логин соответствует логину имени пользователя. Подумайте, как инициализировать класс CurrentUserService со свойством - экземпляром класса User.

//В существующий класс ProfileViewController добавьте свойство типа User и сделайте отображение этой информации на экране профиля, включая изображение аватара.


//В класс LoginViewController добавьте функциональность получения информации о пользователе используя логин через CurrentUserService и передачу этой информации в ProfileViewController.
//Проверьте, что ваша новая функциональность работает: если введен корректный логин, то информация о пользователе передается на экран профиля и там отображается. Если логин неверный, то должно выводиться сообщение о некорректных данных и перехода на профиль в этом случае не должно происходить.

import Foundation
import UIKit

protocol UserService {
    func checkLogin (login : String) -> User?
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
    //let avatar : UIImage
    let status : String

    init(login: String, fio: String, status: String) {
        self.login = login
        self.fio = fio
        //self.avatar = avatar
        self.status = status
    }


}
