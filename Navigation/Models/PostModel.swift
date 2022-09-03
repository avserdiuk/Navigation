//
//  PostModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation

//Создайте модель публикации Post, она должна содержать следующие поля: author: String - никнейм автора публикации description: String - текст публикации image: String - имя картинки из каталога Assets.xcassets likes: Int - количество лайков views: Int - количество просмотров

struct Post {
        var autor: String
        var description: String
        var image: String
        var likes: Int
        var views: Int
}
