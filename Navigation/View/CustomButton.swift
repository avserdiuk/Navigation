//
//  CustomButton.swift
//  Navigation
//
//  Created by Алексей Сердюк on 21.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

class CustomButton : UIButton {

    var btnAction : () -> Void = {}

    @objc private func buttonTapped(){
        btnAction()
    }

    // иннициализатор с дефолтными параметрами кнопки, но если нужно задать какое то свойста - делаем это при создании кнопки
    init(title: String, backgroundColor: UIColor = .systemBlue, cornerRadius: CGFloat = 0, maskToBounds : Bool = true){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = maskToBounds
        self.setTitleColor(UIColor.white, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}

