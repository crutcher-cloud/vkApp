//
//  Group.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
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
    dynamic var id: Int? = 0
    dynamic var name: String? = ""
    dynamic var photo: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
    }
}
