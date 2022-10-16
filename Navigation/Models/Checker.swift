//
//  Checker.swift
//  Navigation
//
//  Created by Алексей Сердюк on 15.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate{
    func check(
        _ sender: LoginViewController,
        login : String,
        password: String
    ) -> Bool
}

class Checker {
    static let shared = Checker()

    private let login : String = "login"
    private let password: String = "password"

    func check(login : String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }

    private init(){

    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ sender: LoginViewController, login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}

// --------------------------------------

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory : LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
