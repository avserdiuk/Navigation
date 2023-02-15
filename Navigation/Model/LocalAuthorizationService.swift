//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.02.2023.
//  Copyright © 2023 aserdiuk. All rights reserved.
//

// Основное задание
//- Создайте класс LocalAuthorizationService
//- Создайте в этом классе метод func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void), где Bool будет служить успешной/неуспешной авторизацией
//- Внутри метода добавьте проверку возможности использования биометрии
//- Авторизацию по биометрии
//- Вызов authorizationFinished по результату проверки и авторизации
//- На экране авторизации добавьте кнопку авторизации по биометрии
//
// Дополнительное задание * (со звездочкой)
//- В классе LocalAuthorizationService добавьте переменную, которая будет отдавать информацию о том, какой тип авторизации доступен пользоватлею FaceID/TouchID. В зависимости от типа, установите иконку на кнопку
//- Дополнительно в authorizationFinished добавьте возможность передачи ошибки в виде параметра
//- На экране авторизации добавьте обработку ошибок от биометрии и их вывод пользователю


import Foundation
import LocalAuthentication

class LocalAuthorizationService {

    let context = LAContext()
    let policy : LAPolicy = .deviceOwnerAuthenticationWithBiometrics

    var error: NSError?

    var type : LABiometryType = .none

    // для авторизации
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        let result = context.canEvaluatePolicy(policy, error: &error)

        if result {
            context.evaluatePolicy(policy, localizedReason: "Verify your Identity") { result, error in
                authorizationFinished(result, error)
            }
        } else {
            print("Биометрия отключена")
        }

    }

    // для постановки иконки на кнопку
    func canEvaluate() -> Int {
        let result = context.canEvaluatePolicy(policy, error: &error)

        if result {
            type = context.biometryType
            return type.rawValue
        }else {
            return 0
        }
    }
}

