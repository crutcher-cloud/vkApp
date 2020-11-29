//
//  User.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import RealmSwift

struct UserListResponse: Decodable {
    let response: UserAPIResponse
}

struct UserAPIResponse: Decodable {
    let count: Int?
    let items: [User]?
}

class User: Object, Decodable {
    dynamic var id: Int? = 0
    @objc dynamic var firstName: String? = ""
    @objc dynamic var lastName: String? = ""
    @objc dynamic var photo: String? = ""
    dynamic var isOnline: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case isOnline = "online"
    }
}
