//
//  Extensions.swift
//  Navigation
//
//  Created by Алексей Сердюк on 28.01.2023.
//  Copyright © 2023 aserdiuk. All rights reserved.
//

import Foundation
import UIKit


// Добавляем расширение по заданию из слайда 10

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {guard #available(iOS 13.0, *) else {
        return lightMode
    }
        return UIColor { (traitCollection) -> UIColor in return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode

        }
    }
}

// Создаем единую палитру цветов с помощью расщирения. Далее в коде не будем дублировать вызов функции, а просто передавать переменную как цвет

let colorMainBackground : UIColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray)
let colorSecondaryBackground : UIColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray4)
let colorBorder : UIColor = UIColor.createColor(lightMode: .lightGray, darkMode: .white)
let colorTextColor : UIColor = UIColor.createColor(lightMode: .black, darkMode: .white)


// TabBar
let colorTabBarMainBackground = UIColor.createColor(lightMode:  UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1), darkMode: .systemGray6)
let colorTabBarTint = UIColor.createColor(lightMode:  .systemBlue, darkMode: .white)
