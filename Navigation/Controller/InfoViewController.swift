//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 15.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController : UIViewController, UITableViewDelegate{

    // создаем алерт c заголовок и сообщением
    let alertController = UIAlertController(title: "TitlPfujke", message: "Test Message", preferredStyle: .alert)

    // создаем кастомные кнопки для закрытия модального кона
    private lazy var button: CustomButton = CustomButton(title: " Close ")
    private lazy var buttonAlert: CustomButton = CustomButton(title: " Alert ")

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tatuinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground

        // проставляем элементы на экране
        view.addSubview(button)
        //view.addSubview(buttonAlert)
        view.addSubview(titleLabel)
        view.addSubview(tatuinLabel)
        view.addSubview(tableView)

        addConstraints()
        addBtnActions()

        // добавляем события для алерта
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        alertController.addAction(UIAlertAction(title: "Close", style: .default))

        titleLabel.text = HW1.data
        tatuinLabel.text = HW2.data

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()

        }
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
//            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tatuinLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tatuinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func addBtnActions(){
        button.btnAction = {
            self.dismiss(animated: true, completion: nil)
        }

        buttonAlert.btnAction = {
            self.present(self.alertController, animated: true, completion: nil)
        }
    }

}

extension InfoViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Настраиваем кол-во строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }

    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)

        NetworkManager.request(for: residents[indexPath.row], index: indexPath.row)
        cell.textLabel?.text = residentsName[indexPath.row]

        return cell

    }
}
