//
//  PhotoItemModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 06.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

// Необходимый размер для ячеек (по заданию)
let itemSizeInCollection = (UIScreen.main.bounds.width - 32)/3

// Массив с названием картинок для галлерии
let itamData : [String] = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png", "11.png", "12.png", "13.png", "14.png", "15.png"]


var photos : [UIImage] = [UIImage(named: "1.png")!, UIImage(named: "2.png")!, UIImage(named: "3.png")!, UIImage(named: "4.png")!]
