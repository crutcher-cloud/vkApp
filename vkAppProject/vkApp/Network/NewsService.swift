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
    func getNews(startTime: Double, completion: @escaping () -> Void) {
        let token = session.token
        let apiVersion = "5.126"
        

        AF.request("https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&v=\(apiVersion)&start_time=\(startTime)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let news = try JSONDecoder().decode(NewsListResponse.self, from: data)
                    self.newsList.insert(contentsOf: news.response.items!, at: 0)

                    completion()
                } catch { print(error) }
            }
        })
        
    }
    
    func setDate(unixDate: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    @objc func refreshNews() {
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновление")
        refreshControl?.tintColor = .blue
        let mostFreshNewsDate = self.newsList.first?.date ?? Date().timeIntervalSince1970
        getNews(startTime: mostFreshNewsDate + 1, completion: { [self] in
            guard newsList.count > 0 else { return }
            tableView.reloadData()
            
            refreshControl?.endRefreshing()
        })
        
    }
}
