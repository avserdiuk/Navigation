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
    

    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return table
    }()

    var content = FileManagerService().contentsOfDirectory()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)
        self.title = "File Manager"

        let createFolderItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createFolder))
        let addPhotoItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
        navigationItem.rightBarButtonItems = [addPhotoItem, createFolderItem]

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        print("------------------")


        do {
            let documentsDirectoryUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            //print(documentsDirectoryUrl)
            //print(documentsDirectoryUrl.path)

            let test = documentsDirectoryUrl.appendingPathComponent("Test")
            //print(test)
            // создание директории
            //            do {
            //                try FileManager.default.createDirectory(at: test, withIntermediateDirectories: false)
            //            } catch {
            //                print(error)
            //            }

            // создание файла в директории

            let test2 = test.appendingPathComponent("myFile2")
            //print(test2)

            //            do {
            //                try FileManager.default.createFile(atPath: test2.path, contents: Data())
            //            } catch {
            //                print(error)
            //            }

            // Удаление файла или директории

            //            do {
            //                try FileManager.default.removeItem(at: test)
            //            } catch {
            //                print(error)
            //            }

            //Запросить все файлы в директории

            //            do {
            //                let content = try FileManager.default.contentsOfDirectory(atPath: documentsDirectoryUrl.path)
            //
            //                for (index, item) in content.enumerated() {
            //                    print(item)
            //                }
            //            } catch {
            //                print(error)
            //            }


        } catch {
            print(error)
        }
        print("------------------")
    }

    @objc
    func createFolder(){
        print("createFolder")

        showInputDialog(title: "Add new folder",
                        subtitle: "Please enter the name",
                        actionTitle: "Add",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "New folder name",
                        inputKeyboardType: .default, actionHandler:
                            { (input:String?) in
            //print("The new number is \(input ?? "")")
            FileManagerService().createDirectory(name: input ?? "") { result in

                self.content = FileManagerService().contentsOfDirectory()

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            

        })

        


        
    }

    @objc
    func addPhoto(){
        print("addPhoto")
        let picker = UIImagePickerController()
        //           picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
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

    // Обработка клика на секцию с фотографиями. При клике переходим на другое вью контроллер PhotosViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if FileManagerService().checkDirectory(name: content[indexPath.row]) {
            print("Click to folder")
        }
    }

    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        cell.textLabel?.text = content[indexPath.row]

        if FileManagerService().checkDirectory(name: content[indexPath.row]) {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}



