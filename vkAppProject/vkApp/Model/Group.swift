//
//  Group.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation

struct GroupListResponse: Decodable {
    let response: GroupAPIResponse
}

struct GroupAPIResponse: Decodable {
    let count: Int?
    let items: [Group]?
}

struct Group: Decodable {
    var id: Int?
    var name: String?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.photo = try? container.decode(String.self, forKey: .photo)
    }
}
