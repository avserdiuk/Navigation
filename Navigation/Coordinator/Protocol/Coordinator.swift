//
//  Coordinators.swift
//  Navigation
//
//  Created by Алексей Сердюк on 30.10.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit

protocol Coordinator {
    var child : [Coordinator] { get set}
}
