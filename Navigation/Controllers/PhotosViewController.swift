//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 05.09.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Photo Gallery"

        view.backgroundColor = .white


    }
}
