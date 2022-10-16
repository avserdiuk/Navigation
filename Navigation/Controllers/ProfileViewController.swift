//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController : UIViewController {

    // создаем пользователя по заданию
    var user_1 : User = User(fio: "", avatar: UIImage() ,status: "")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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

    private lazy var hiddenView : UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var hiddenAvatar : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatarImage")
        img.layer.cornerRadius = 50
        img.layer.masksToBounds = true
        img.isHidden = true
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()

    private lazy var hiddenCloseView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "xmark")
        img.tintColor = .white
        img.isHidden = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true

        // если мы в дебаг версии то меняем цвет фона, иначе оставляем все как было
        #if DEBUG
            view.backgroundColor = .red
        #else
            view.backgroundColor = UIColor(red: 245/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1)
        #endif

        addViews()
        addConstraints()
        addGestures()
        addNotification()


    }

    @objc func didAvatarClick(notification: Notification) {
        showAnimation()
    }

    // функция выполняющаяся при нажатие на аватарку
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer){
        showAnimation()
    }

    // функция выполняющаяся при нажатие на иконку закрыть
    @objc func tabClose(_ gestureRecognizer: UITapGestureRecognizer){
        closeAnimation()
    }

    // функция анимации аватарки
    private func showAnimation() {

        // вычисляем ширину коэфициент на который нужно соскейлить аватарку
        let scaleCoef = self.hiddenView.frame.width / self.hiddenAvatar.frame.width


        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            // отображаем скрытую аватарку, вью и кнопку
            self.hiddenAvatar.isHidden = false
            self.hiddenView.isHidden = false

            // ставим аву по центре и увеличиваем ее
            self.hiddenAvatar.center = self.hiddenView.center
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: scaleCoef, y: scaleCoef)
            self.hiddenAvatar.isUserInteractionEnabled = false

            // делаем бекграунд полупрозрачным
            self.hiddenView.alpha = 0.5

        } completion: { _ in
            // по окончанию основной анимации показываем кнопку закрыть
            UIView.animate(withDuration: 0.3, animations: {
                self.hiddenCloseView.isHidden = false
            })
        }
    }

    // анимация при закрытии
    private func closeAnimation() {

        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            // возвращаем аву и ее размеры на место
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: 1, y: 1)

            // возвращаем аватарку на стартовую позицию по заранее известным точкам так как аватарка у нас статичка и ее размер не изменяется. НО вообще можно было бы сделать динамическое вычисление этих точек, но пока не додумался что то(
            self.hiddenAvatar.center = CGPoint(x: 66, y: 86)

            self.hiddenView.alpha = 0 // скрываем бекграунд

            self.hiddenCloseView.isHidden = true // скрываем кнопку закрыть

            self.hiddenAvatar.isUserInteractionEnabled = true // скрываем возможность кликать на скрытую аватарку пока она увеличена

        } completion: { _ in
            // по окончанию отправяем уведомления о закрытии
            NotificationCenter.default.post(name: Notification.Name("closeClick!"), object: nil)
            self.hiddenAvatar.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    func addNotification(){
        // уведомление о клике на аватарку, что бы скрыть основную и показать все скрытое
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAvatarClick(notification:)),
                                               name: Notification.Name("avaClick!"),
                                               object: nil)
    }

    func addViews(){
        view.addSubview(tableView)
        view.addSubview(hiddenView)
        view.addSubview(hiddenAvatar)
        view.addSubview(hiddenCloseView)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            hiddenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hiddenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            hiddenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            hiddenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            hiddenAvatar.topAnchor.constraint(equalTo: hiddenView.topAnchor, constant: 16),
            hiddenAvatar.leftAnchor.constraint(equalTo: hiddenView.leftAnchor, constant: 16),
            hiddenAvatar.widthAnchor.constraint(equalToConstant: 100),
            hiddenAvatar.heightAnchor.constraint(equalToConstant: 100),

            hiddenCloseView.topAnchor.constraint(equalTo: hiddenView.topAnchor, constant: 16),
            hiddenCloseView.rightAnchor.constraint(equalTo: hiddenView.rightAnchor, constant: -16),
            hiddenCloseView.widthAnchor.constraint(equalToConstant: 25),
            hiddenCloseView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

    func addGestures(){
        // для клика на аватарку
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        self.hiddenAvatar.addGestureRecognizer(tapGestureRecognizer)

        // для клика на кнопвку закрыть
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.tabClose(_:)))
        self.hiddenCloseView.addGestureRecognizer(tapGestureRecognizer2)
    }
    
}

extension ProfileViewController : UITableViewDelegate {

    // Настраиваем кастомный хэдер для 1 секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0  {
            // устанавливаем значения из нашего пользователя по заданию
            let profile = ProfileHeaderView()
            profile.setup(user: user_1)
            return profile
        }
        return nil
    }
}

extension ProfileViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Настраиваем кол-во строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }

        if section == 1 {
            return posts.count
        }

        return 0
    }

    // Обработка клика на секцию с фотографиями. При клике переходим на другое вью контроллер PhotosViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: false)
        }
    }

    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.section == 0 { // В 0 секрции у нас 1 строка куда ставим ленту фотографий
            return PhotoTableViewCell()
        } else if indexPath.section == 1 { // для 1 секции строки заполняем постами
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellIdentifier", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
                return cell
            }

            var post = posts[indexPath.row]

            // Добавляем фильтр на картинку поста (притом разные, так как это сказано в задании)
            let imageFilter = ImageProcessor()

            if let sImage = post.image { // решаем вопрос с опционалом
                if indexPath.row % 2 == 0 {
                    imageFilter.processImage(sourceImage: sImage, filter: .noir) {
                        filteredImage in post.image = filteredImage
                    }
                } else {
                    imageFilter.processImage(sourceImage: sImage, filter: .colorInvert) {
                        filteredImage in post.image = filteredImage
                    }
                }

            }

            let PostViewModel = PostTableViewCell.ViewModel(
                autor: post.autor,
                descriptionText: post.description,
                likes: "Likes: \(post.likes)",
                views: "Views: \(post.views)",
                image: post.image
            )
            cell.setup(with: PostViewModel)
            return cell

        } else {
            return tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        }
    }
}
