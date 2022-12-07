//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 07.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {

    var sortMethod : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "sortStatus")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sortStatus")
        }
    }

    private lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort files by abc"
        return label
    }()

    private lazy var sortSwitcher : UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(setSort), for: .valueChanged)
        return switcher
    }()

    private lazy var pswdButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Change password ", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Settings"

        view.addSubview(sortLabel)
        view.addSubview(sortSwitcher)
        view.addSubview(pswdButton)

        NSLayoutConstraint.activate([
            sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sortLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            sortSwitcher.centerYAnchor.constraint(equalTo: sortLabel.centerYAnchor),
            sortSwitcher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            pswdButton.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 20),
            pswdButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sortMethod == true {
            sortSwitcher.isOn = true
            print("on")
        } else {
            sortSwitcher.isOn = false
            print("off")
        }
    }

    @objc
    func setSort(){
        if sortSwitcher.isOn {
            sortMethod = true
            print("on")
        } else {
            sortMethod = false
            print("off")
        }
    }

    @objc
    func changePassword(){
        print("show modal")
        let vc = PasswordViewController()
        vc.status = false
        present(vc, animated: true)
    }
}
