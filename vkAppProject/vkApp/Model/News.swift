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
    let items: [News]?
    let groups: [NewsGroupsList]?
    let profiles: [NewsFriendsList]?
    let next_from: String?
}

class News: Decodable {
    @objc dynamic var id = 0
    dynamic var date: Double?
    @objc dynamic var text: String?
    var likes: NewsLikes?
    var comments: NewsComments?
    var reposts: NewsReposts?
    var views: NewsViews?
    
    enum CodingKeys: String, CodingKey {
        case id = "source_id"
        case date
        case text
        case likes
        case comments
        case reposts
        case views
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

class NewsGroupsList: Decodable {
    var id: Int?
    var name: String?
    var photo_50: String?
}

class NewsFriendsList: Decodable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var photo_50: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo_50
    }
}
