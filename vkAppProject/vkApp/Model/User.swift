//
//  User.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import UIKit

struct UserListResponse: Decodable {
    let response: UserAPIResponse
}

struct UserAPIResponse: Decodable {
    let count: Int?
    let items: [User]?
}

struct User: Decodable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var photo: String?
    var isOnline: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case isOnline = "online"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.firstName = try? container.decode(String.self, forKey: .firstName)
        self.lastName = try? container.decode(String.self, forKey: .lastName)
        self.photo = try? container.decode(String.self, forKey: .photo)
        self.isOnline = try? container.decode(Int.self, forKey: .isOnline)
    }
}
