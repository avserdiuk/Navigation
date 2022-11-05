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

class PhotosViewController : UIViewController {

    var filteredImage : [CGImage?] = []

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

        magic()
    }

    func magic(){
        print(DispatchTime.now())
        ImageProcessor.init().processImagesOnThread(sourceImages: photos, filter: .chrome, qos: .default) { img in
            self.filteredImage = img
            self.result()
            print(DispatchTime.now())
        }
    }

    func result(){

        for (index,item) in filteredImage.enumerated() {
            photos[index] = UIImage.init(cgImage: item!)
        }

        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        cell.setupWithIndex(with: indexPath.row)
        return cell
    }
}

extension PhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: itemSizeInCollection, height: itemSizeInCollection)
    }
}
