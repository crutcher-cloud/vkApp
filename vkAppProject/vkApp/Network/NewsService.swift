//
//  NewsService.swift
//  vkApp
//
//  Created by Влад Голосков on 10.01.2021.
//  Copyright © 2021 Владислав Голосков. All rights reserved.
//

import Foundation
import Alamofire

extension NewsTableViewController {
    func getNews(completion: @escaping () -> Void) {
        let token = session.token
        let apiVersion = "5.126"

        AF.request("https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&v=\(apiVersion)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let news = try JSONDecoder().decode(NewsListResponse.self, from: data)
                    let newsList = news.response.items

                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        completion()
                    })
                } catch { print(error) }
            }
        })
        
    }
}
