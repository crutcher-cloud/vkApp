//
//  NewsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var newsList = [News]()
    
    let tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление")
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = tableRefreshControl
        
        getNews(startTime: Date().timeIntervalSince1970 - 1800, completion: {
            self.tableView.reloadData()
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
        
        cell.newsTextLabel.text = newsList[indexPath.row].text
        cell.postDateTimeLabel.text = setDate(unixDate: newsList[indexPath.row].date!)
        //cell.likesLabel.text = String(newsList[indexPath.row].likes!.count)
        
        
//        cell.friendImage.image = friendImages[indexPath.row]
//        cell.friendNameLabel.text = friends[indexPath.row]
//        cell.postDateTimeLabel.text = "06.09.2020 12:31"
        //cell.newsImage.image = newsImages[indexPath.row]

        return cell
    }
}
