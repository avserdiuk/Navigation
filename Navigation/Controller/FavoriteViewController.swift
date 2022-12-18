//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

class FavoriteViewController : UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellIdentifier")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite post"
        view.backgroundColor = .white

        let clear = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        navigationItem.rightBarButtonItems = [clear]

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func clear() {
        CoreDataModel().delete()
        tableView.reloadData()
    }
}

extension FavoriteViewController : UITableViewDelegate {

}

extension FavoriteViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Настраиваем кол-во строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataModel().favoritePosts.count
    }


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }

    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
            return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
                CoreDataModel().deleteFromFavorite(index: indexPath.row)
                self.tableView.reloadData()
                completion(true)
            }
        }


    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellIdentifier", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
                return cell
            }

            let post = CoreDataModel().favoritePosts[indexPath.row]

            let PostViewModel = PostTableViewCell.ViewModel(
                pid: indexPath.row,
                autor: post.autor!,
                descriptionText: post.desc!,
                likes: "\(post.likes)",
                views: "\(post.views)",
                image: "\(post.img!)"
            )
            cell.setup(with: PostViewModel)
            return cell

    }
}
