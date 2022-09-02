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
        Post(autor: "autor1", description: "description1", image: "image1", likes: 1, views: 1),
        Post(autor: "autor2", description: "description2", image: "image2", likes: 2, views: 2),
        Post(autor: "autor3", description: "description3", image: "image3", likes: 3, views: 3),
        Post(autor: "autor4", description: "description4", image: "image4", likes: 4, views: 4)
    ]

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)

        view.addSubview(tableView)
        tableView.backgroundColor = .systemBlue

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

//extension ProfileViewController : UITableViewDelegate {
//
//}
//
//extension ProfileViewController : UITableViewDataSource{
//
//}
