//
//  Group.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import RealmSwift

struct UserGroupListResponse: Decodable {
    let response: UserGroupAPIResponse
}

struct UserGroupAPIResponse: Decodable {
    let count: Int?
    let items: [UserGroup]?
}

class UserGroup: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name: String? = ""
    @objc dynamic var photo: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
