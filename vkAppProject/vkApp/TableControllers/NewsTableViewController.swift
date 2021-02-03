//
//  NewsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var isLoading = false
    var startIndexForNews = ""
    
    var newsList = [News]()
    
    var groupsNameDictionary = [Int: String]()
    var friendsNameDictionary = [Int: String]()
    
    var groupsPhotoDictionary = [Int: UIImage]()
    var friendsPhotoDictionary = [Int: UIImage]()
    
    let tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        
        tableView.refreshControl = tableRefreshControl
        
        getNews(startTime: "", startFrom: startIndexForNews, completion: { [self] in
            tableView.reloadData()
        })
        
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.newsTextLabel.text = newsList[indexPath.row].text!
        cell.postDateTimeLabel.text = setDate(unixDate: newsList[indexPath.row].date!)
        
        cell.commentsLabel.text = String(newsList[indexPath.row].comments?.count ?? 0)
        cell.likesLabel.text = String(newsList[indexPath.row].likes?.count ?? 0)
        cell.forwardsLabel.text = String(newsList[indexPath.row].reposts?.count ?? 0)
        cell.viewsLabel.text = String(newsList[indexPath.row].views?.count ?? 0)
        
        if newsList[indexPath.row].id < 0 {
            cell.friendNameLabel.text = setSourceName(indexPath: indexPath)
            cell.friendImage.image = setSourcePhoto(indexPath: indexPath)
        } else {
            cell.friendNameLabel.text = setSourceName(indexPath: indexPath)
        }
        
        return cell
    }
}
