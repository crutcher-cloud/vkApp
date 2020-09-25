//
//  Session.swift
//  vkApp
//
//  Created by Влад Голосков on 25.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation

class Session {
    static let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
}
