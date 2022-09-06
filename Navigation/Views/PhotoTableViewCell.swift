//
//  PhotoTableViewCell.swift
//  Navigation
//
//  Created by Алексей Сердюк on 05.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class PhotoTableViewCell: UITableViewCell {

    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Photos"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        return titleLabel
    }()

    private let arrowImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.right")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .black
        return img
    }()

    private lazy var img1 : UIImageView = {
        let img = UIImageView()
        img.image =  UIImage(named: "img1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    private lazy var img2 : UIImageView = {
        let img = UIImageView()
        img.image =  UIImage(named: "img1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    private lazy var img3 : UIImageView = {
        let img = UIImageView()
        img.image =  UIImage(named: "img1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    private lazy var img4 : UIImageView = {
        let img = UIImageView()
        img.image =  UIImage(named: "img1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //self.backgroundColor = .systemGray
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        self.addSubview(img1)
        self.addSubview(img2)
        self.addSubview(img3)
        self.addSubview(img4)

        // TODO: разобраться с растановкой!
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),

            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),

            img1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            img1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            img1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            img1.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),
            img1.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),

            img2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            img2.leftAnchor.constraint(equalTo: img1.rightAnchor, constant: 8),
            img2.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),
            img2.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),

            img3.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            img3.leftAnchor.constraint(equalTo: img2.rightAnchor, constant: 8),
            img3.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),
            img3.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),

            img4.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            img4.leftAnchor.constraint(equalTo: img3.rightAnchor, constant: 8),
            img4.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),
            img4.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-48)/4),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
