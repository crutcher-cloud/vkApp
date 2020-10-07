//
//  Photo.swift
//  vkApp
//
//  Created by Влад Голосков on 04.10.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation

struct PhotoListResponse: Decodable {
    let response: PhotoAPIResponse
}

struct PhotoAPIResponse: Decodable {
    let count: Int?
    let items: [Photo]?
}

struct Photo: Decodable {
    var sizes: [PhotoSizes]?
}

struct PhotoSizes: Decodable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
