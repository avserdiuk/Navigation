//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Сердюк on 16.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileHeaderView : UIView {

    var statusText : String = ""

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        button.widthAnchor.constraint(equalToConstant: 340).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        img.image = UIImage(named: "image")
        img.layer.cornerRadius = 50
        img.layer.masksToBounds = true
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        return img
    }()

    private let textField : UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 140, y: 84, width: 220, height: 40)
        textField.placeholder = "Enter text here"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "HelveticaNeue", size: 15.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        addConstraints()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func buttonPressed() {
        if let text = statusLabel.text {
            print(text)
        }
        if statusText != "" {
            statusLabel.text = statusText
        }

    }
    @objc func statusTextChanged(_ textField: UITextField){
        if let text = textField.text {
            statusText = text
        }
    }

    func addViews(){
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(button)
        addSubview(image)
        addSubview(textField)
    }

    func addConstraints(){
       NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),

            statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 54),
            statusLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),

            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 132),
        ])
    }

}
