//
//  News.swift
//  vkApp
//
//  Created by Влад Голосков on 10.01.2021.
//  Copyright © 2021 Владислав Голосков. All rights reserved.
//

import Foundation

struct NewsListResponse: Decodable {
    let response: NewsAPIResponse
}

struct NewsAPIResponse: Decodable {
    let count: Int?
    let items: [News]?
}

class News: Decodable {
    @objc dynamic var id = 0
    @objc dynamic var date = 0
    @objc dynamic var text: String?
    var likes: NewsLikes?
    var comments: NewsComments?
    var reposts: NewsReposts?
    var views: NewsViews?
    
    enum CodingKeys: String, CodingKey {
        case id = "source_id"
    }
}

class NewsLikes: Decodable {
    @objc dynamic var count = 0
    @objc dynamic var user_likes = 0
}

class NewsComments: Decodable {
    @objc dynamic var count = 0
}

class NewsReposts: Decodable {
    @objc dynamic var count = 0
    @objc dynamic var user_reposted = 0
}

class NewsViews: Decodable {
    @objc dynamic var count = 0
}
