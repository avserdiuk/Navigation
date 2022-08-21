//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.08.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    let profileView: UIView = {
        let view = ProfileHeaderView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        self.title = "Profile"
        
        view.addSubview(profileView)
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();

        let window = UIApplication.shared.windows.first
        let topPadding = window!.safeAreaInsets.top

        profileView.frame = CGRect(x: 0, y: topPadding+45, width: super.view.frame.width, height: super.view.frame.height)

    }
    
    
    
    
}
