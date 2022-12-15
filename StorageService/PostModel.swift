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
public let itemSize = (UIScreen.main.bounds.width - 48)/4

// структура поста
public struct Post {
    public var autor: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

// массив с данными для ленты постов
public var posts : [Post] = [
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: "img1", likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: "img2", likes: 766, views: 893),
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: "img1", likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: "img2", likes: 766, views: 893),
    Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: "img1", likes: 240, views: 312),
    Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: "img2", likes: 766, views: 893),
]
