//
//  PostModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 02.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

// размер для ячеек в первой секции (по заданию)
let itemSize = (UIScreen.main.bounds.width - 48)/4

// структора поста
struct Post {
        var autor: String
        var description: String
        var image: UIImage?
        var likes: Int
        var views: Int
}

// массив с данными для ленты постов
var posts : [Post] = [
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
]
