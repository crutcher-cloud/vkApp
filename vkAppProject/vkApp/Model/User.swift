//
//  User.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import UIKit

class User {
    let image: [UIImage]
    let name: String
    
    init(image: [UIImage], name: String) {
        self.image = image
        self.name = name
    }
}
