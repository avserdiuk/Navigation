//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 05.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit
import iOSIntPackage

class PhotosViewController : UIViewController, ImageLibrarySubscriber {

    // нужное для реализация заполнения коллекции через паттерн фасад
    var itemInSection : Int = 0
    var itemImageMassive : [UIImage] = []
    var imagePublisher = ImagePublisherFacade()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Photo Gallery"
        

        view.backgroundColor = .white

        addViews()
        addConstraints()

        // запускаем подписку и генерацию картинок
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(time: 0.5, repeat: 20)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePublisher.subscribe(self)
    }

    // отписываемся от наблюдения при смене статус контроллера или нажатии кнопки back
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePublisher.removeSubscription(for: self)
        imagePublisher.rechargeImageLibrary()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            imagePublisher.removeSubscription(for: self)
            imagePublisher.rechargeImageLibrary()
        }
    }

    func addViews(){
        view.addSubview(collectionView)

    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        cell.setupWithImage(with: itemImageMassive[indexPath.row])
        return cell
    }
}

extension PhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: itemSizeInCollection, height: itemSizeInCollection)
    }
}

extension PhotosViewController  {
    func receive(images: [UIImage]) {
        itemImageMassive = images
        itemInSection = images.count
        collectionView.reloadData()
    }
}

