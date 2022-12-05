//
//  FileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 03.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class FileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var currentDirectory : URL = FileManagerService().documentsDirectoryUrl
    var content : [String] = []


    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return table
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)


        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        print("Current dir: \(currentDirectory)")

    }


}

extension FileViewController : UITableViewDelegate {
}

extension FileViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Настраиваем кол-во строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    // Обработка клика на строку в таблице. При клике переходим на другое вью контроллер
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let rowURL = currentDirectory.appendingPathComponent(content[indexPath.row])

        if FileManagerService().checkDirectory(url: rowURL) {

            let viewController = FileViewController()
            viewController.currentDirectory = rowURL
            viewController.content = FileManagerService().contentsOfDirectory(viewController.currentDirectory)
            viewController.title = "\(content[indexPath.row])"
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        cell.textLabel?.text = content[indexPath.row]

        if FileManagerService().checkDirectory(url: currentDirectory.appendingPathComponent(content[indexPath.row])) {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}



