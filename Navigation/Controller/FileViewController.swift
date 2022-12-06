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

//    let alertController = UIAlertController(title: "TitlPfujke", message: "Test Message", preferredStyle: .alert)
//    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
//    alertController.addAction(UIAlertAction(title: "Close", style: .default))

    var currentDirectory : URL = FileManagerService().documentsDirectoryUrl
    var content : [String] = []

//    private lazy var alert : UIAlertController = {
//        let alert = UIAlertController(title: "Create a new folder", message: "Please write name for a new folder", preferredStyle: .alert)
//        alert.addTextField()
//        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { res in
//            print(alert.textFields![0])
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
//
//        return alert
//    }()

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

        let createFolderItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createFolder))
        navigationItem.rightBarButtonItems = [createFolderItem]

        view.addSubview(tableView)


        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

    }

    @objc
    func createFolder(){

    //TODO: разобраться как работает алерт и обработать ошибки ввода

        showInputDialog(title: "Create a new folder", actionHandler:  { text in
            if let result = text {
                let url = self.currentDirectory.appendingPathComponent(result)

                FileManagerService().createDirectory(url) {
                    self.content = FileManagerService().contentsOfDirectory(self.currentDirectory)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })

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

        let URL = currentDirectory.appendingPathComponent(content[indexPath.row])

        if FileManagerService().checkDirectory(URL) {

            let viewController = FileViewController()
            viewController.currentDirectory = URL
            viewController.content = FileManagerService().contentsOfDirectory(viewController.currentDirectory)
            viewController.title = "\(content[indexPath.row])"
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        cell.textLabel?.text = content[indexPath.row]

        if FileManagerService().checkDirectory(currentDirectory.appendingPathComponent(content[indexPath.row])) {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}



