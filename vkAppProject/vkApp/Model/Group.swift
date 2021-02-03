//
//  Group.swift
//  vkApp
//
//  Created by Влад Голосков on 05.12.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import RealmSwift

struct GroupListResponse: Decodable {
    let response: GroupAPIResponse
}

struct GroupAPIResponse: Decodable {
    let count: Int?
    let items: [Group]?
}

class Group: Object, Decodable {
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
