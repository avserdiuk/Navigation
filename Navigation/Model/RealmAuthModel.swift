//
//  RealmAuthModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 12.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser : Object {
    @Persisted var login : String?
    @Persisted var password: String?
    @Persisted var lastAuth: Double? = nil

    convenience init(login: String, password: String) {
           self.init()
           self.login = login
           self.password = password
       }
}
