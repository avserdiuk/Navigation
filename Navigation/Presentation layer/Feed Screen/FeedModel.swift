//
//  FeedModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 17.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.

import Foundation

// создание структуры по старому заданию
struct PostFeed {
    var title : String
}

// создание модели по новому заданию
struct FeedModel {
    let password : String = "1"

    func check(word: String) -> Bool {
        password == word ? true : false
    }
}
