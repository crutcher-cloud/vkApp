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
    func getNews(startTime: String,
                 startFrom: String = "",
                 completion: @escaping () -> Void) {
        let token = session.token
        let apiVersion = "5.126"
        
        
        AF.request("https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&v=\(apiVersion)&start_time=\(startTime)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let news = try JSONDecoder().decode(NewsListResponse.self, from: data)
                    if startFrom != "" {
                        self.newsList.insert(contentsOf: news.response.items!, at: 0)
                    } else {
                        self.newsList.insert(contentsOf: news.response.items!, at: self.newsList.endIndex)
                    }
                    
                    self.groupsNameDictionary.merge(other: self.setGroupsNameDictionary(groups: news.response.groups!))
                    self.groupsPhotoDictionary.merge(other: self.setGroupsPhotoDictionary(groups: news.response.groups!))
                    
                    self.friendsNameDictionary.merge(other: self.setFriendsNameDictionary(friends: news.response.profiles!))
                    self.friendsPhotoDictionary.merge(other: self.setFriendsPhotoDictionary(friends: news.response.profiles!))
                    
                    self.startIndexForNews = news.response.next_from ?? ""
                    
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
    
    func setGroupsNameDictionary(groups: [NewsGroupsList]) -> [Int: String] {
        var ids = [Int]()
        var names = [String]()
        
        var groupsNameDict = [Int: String]()
        
        if groups.count == 0 {
            return groupsNameDict
        } else {
            for i in 0...groups.count - 1 {
                ids.append(groups[i].id!)
                names.append(groups[i].name!)
            }
            
            let seq = zip(ids, names)
            groupsNameDict = Dictionary(uniqueKeysWithValues: seq)
            
            return groupsNameDict
        }
    }
    
    func setGroupsPhotoDictionary(groups: [NewsGroupsList]) -> [Int: UIImage] {
        var ids = [Int]()
        var photos = [UIImage]()
        
        var groupsPhotoDict = [Int: UIImage]()
        
        if groups.count == 0 {
            return groupsPhotoDict
        } else {
        for i in 0...groups.count - 1 {
            ids.append(groups[i].id!)
            photos.append(groups[i].photo_50!.toImage()!)
        }
        
        let seq = zip(ids, photos)
        groupsPhotoDict = Dictionary(uniqueKeysWithValues: seq)
        
        return groupsPhotoDict
        }
    }
    
    func setFriendsNameDictionary(friends: [NewsFriendsList]) -> [Int: String] {
        var ids = [Int]()
        var names = [String]()
        
        var friendsNameDict = [Int: String]()
        
        if friends.count == 0 {
            return friendsNameDict
        } else {
            for i in 0...friends.count - 1 {
                ids.append(friends[i].id!)
                names.append("\(friends[i].firstName!) \(friends[i].lastName!)")
            }
            
            let seq = zip(ids, names)
            friendsNameDict = Dictionary(uniqueKeysWithValues: seq)
            
            return friendsNameDict
        }
    }
    
    func setFriendsPhotoDictionary(friends: [NewsFriendsList]) -> [Int: UIImage] {
        var ids = [Int]()
        var photo = [UIImage]()
        
        var friendsPhotoDict = [Int: UIImage]()
        
        if friends.count == 0 {
            return friendsPhotoDict
        } else {
            for i in 0...friends.count - 1 {
                ids.append(friends[i].id!)
                photo.append(friends[i].photo_50!.toImage()!)
            }
            
            let seq = zip(ids, photo)
            friendsPhotoDict = Dictionary(uniqueKeysWithValues: seq)
            
            return friendsPhotoDict
        }
    }
    
    func setSourceName(indexPath: IndexPath) -> String {
        let sourceId = newsList[indexPath.row].id
        if sourceId < 0 {
            let name = self.groupsNameDictionary[sourceId * -1]
            return name ?? "UNKNOWN GROUP"
        } else {
            let name = self.groupsNameDictionary[sourceId]
            return name ?? "UNKNOWN FRIEND"
        }
    }
    
    func setSourcePhoto(indexPath: IndexPath) -> UIImage {
        let sourceId = newsList[indexPath.row].id
        if sourceId < 0 {
            let photo = self.groupsPhotoDictionary[sourceId * -1] ?? UIImage(named: "logo")
            return photo!
        } else {
            let photo = self.groupsPhotoDictionary[sourceId]
            return photo!
        }
    }
    
    @objc func refreshNews() {
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        let mostFreshNewsDate = self.newsList.first?.date ?? Date().timeIntervalSince1970
        getNews(startTime: String(mostFreshNewsDate + 1), completion: { [self] in
            guard newsList.count > 0 else { return }
            tableView.reloadData()
            
            refreshControl?.endRefreshing()
        })
        
    }
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let maxIndex = indexPaths.max()?.row ?? 0
        if maxIndex == newsList.count - 3, !isLoading {
            print("UPDATING...")
            getNews(startTime: "", startFrom: startIndexForNews, completion: {
                self.tableView.reloadData()
            })
            self.isLoading = false
        }
    }
}
