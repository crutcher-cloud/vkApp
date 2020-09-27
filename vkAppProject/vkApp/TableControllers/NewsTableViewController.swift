//
//  NewsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news = [String]()
    var newsImages = [UIImage(named: "IIvanov1"), UIImage(named: "YSergeeva1"), UIImage(named: "AVasilyev")]
    var friendImages = [UIImage(named: "AVasilyev"), UIImage(named: "YSergeeva"), UIImage(named: "IIvanov")]
    var friends = ["Антон Васильев", "Юлия Сергеева", "Иван Иванов"]

    override func viewDidLoad() {
        super.viewDidLoad()

        news.append("Идейные соображения высшего порядка, а также дальнейшее развитие различных форм деятельности позволяет оценить значение новых предложений. . Товарищи! консультация с широким активом позволяет выполнять важные задания по разработке систем массового участия.")
        
        news.append("Hello world!")
        
        news.append("Donec in dui nec nulla sagittis fermentum. Etiam malesuada posuere purus in faucibus. Maecenas non nunc suscipit urna blandit suscipit ut eget sem. Duis dictum leo vitae arcu elementum hendrerit. Vivamus quis hendrerit lectus, placerat rhoncus urna. Nulla vitae convallis libero, sed consequat ex. Vivamus mollis elementum turpis sed dapibus. In pharetra, eros sit amet scelerisque congue, felis purus aliquam velit, dapibus malesuada nunc enim sit amet purus. Pellentesque egestas sem vitae sapien porta varius. Nam felis arcu, commodo eget nunc in, dapibus ultrices nisi. Curabitur id fermentum odio. Nunc eu condimentum nisi.")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.newsTextLabel.text = news[indexPath.row]
        
        cell.friendImage.image = friendImages[indexPath.row]
        cell.friendNameLabel.text = friends[indexPath.row]
        cell.postDateTimeLabel.text = "06.09.2020 12:31"
        cell.newsImage.image = newsImages[indexPath.row]
        // Configure the cell...

        return cell
    }
}
