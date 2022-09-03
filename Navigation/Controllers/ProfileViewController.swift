//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    var posts : [Post] = [
        Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
        Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
        Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
        Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
        Post(autor: "vedmak.official", description: "Новые кадры со сьемок второго сезона сериала \"Ведьмак \"", image: UIImage(named: "img1"), likes: 240, views: 312),
        Post(autor: "Нетология. Меняем карьеру через образование.", description: "«Нетоло́гия» — российская компания и образовательная онлайн-платформа, запущенная в 2011 году. Одна из ведущих российских компаний онлайн-образования[1]. Входит в IT-холдинг TalentTech, объединяющий компании по трём направлениям: EdTech, HRTech и Freelance. EdTech-сегмент холдинга, наряду с «Нетологией» (включая EdMarket), представлен компаниями «Фоксфорд» и «TalentTech.Обучение».", image: UIImage(named: "img2"), likes: 766, views: 893),
    ]
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellIdentifier")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        
        view.addSubview(tableView)
        
        addConstraints()
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension ProfileViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }
}

extension ProfileViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellIdentifier", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
            return cell
        }

        let post = self.posts[indexPath.row]

        let viewModel = PostTableViewCell.ViewModel(
            autor: post.autor,
            descriptionText: post.description,
            likes: "Likes: \(post.likes)",
            views: "Views: \(post.views)",
            image: post.image
        )
        cell.setup(with: viewModel)
        
        return cell
    }
}
