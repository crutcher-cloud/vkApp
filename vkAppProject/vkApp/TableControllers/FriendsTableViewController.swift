//
//  FriendsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsDictionary: [String: [User]] = [:]
    var friendsSectionTitles = [String]()
    var friends = [
        User(image: [UIImage(named: "IIvanov") ?? UIImage(named: "logo")!, UIImage(named: "IIvanov1") ?? UIImage(named: "logo")!], name: "Иванов Иван"),
        User(image: [UIImage(named: "YSergeeva") ?? UIImage(named: "logo")!, UIImage(named: "YSergeeva1") ?? UIImage(named: "logo")!], name: "Сергеева Юлия"),
        User(image: [UIImage(named: "AVasilyev") ?? UIImage(named: "logo")!], name: "Васильев Антон"),
        User(image: [UIImage(named: "GVinogradov") ?? UIImage(named: "logo")!], name: "Виноградов Геннадий"),
        User(image: [UIImage(named: "NSolovyev") ?? UIImage(named: "logo")!], name: "Соловьёв Николай"),
        User(image: [UIImage(named: "LSavin") ?? UIImage(named: "logo")!], name: "Савин Леонид"),
        User(image: [UIImage(named: "ABelozerov") ?? UIImage(named: "logo")!], name: "Белозёров Афанасий"),
        User(image: [UIImage(named: "AIgnatyev") ?? UIImage(named: "logo")!], name: "Игнатьев Архип"),
        User(image: [UIImage(named: "ASidorov") ?? UIImage(named: "logo")!], name: "Сидоров Адольф"),
        User(image: [UIImage(named: "AGordeeva") ?? UIImage(named: "logo")!], name: "Гордеева Аэлита"),
        User(image: [UIImage(named: "DArkhipova") ?? UIImage(named: "logo")!], name: "Архипова Джульетта"),
        User(image: [UIImage(named: "MNikonova") ?? UIImage(named: "logo")!], name: "Никонова Мальта"),
        User(image: [UIImage(named: "GOvchinnikova") ?? UIImage(named: "logo")!], name: "Овчинникова Гертруда"),
        User(image: [UIImage(named: "SGulyaeva") ?? UIImage(named: "logo")!], name: "Гуляева Симона")
    ]
    
    var filteredFriendsDictionary: [String: [User]] = [:] //Словарь друзей, использующийся для поиска
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        //Заполнение словаря с друзьями в формате "первая буква" : [друзья]
        for friend in friends {
            let friendKey = String(friend.name.prefix(1))
            if var friendValues = friendsDictionary[friendKey] {
                friendValues.append(friend)
                friendsDictionary[friendKey] = friendValues
            } else {
                friendsDictionary[friendKey] = [friend]
            }
        }
        
        filteredFriendsDictionary = friendsDictionary
        
        friendsSectionTitles = [String] (friendsDictionary.keys)
        friendsSectionTitles = friendsSectionTitles.sorted(by: {$0 < $1})
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return friendsSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let friendKey = friendsSectionTitles[section]
        
        if let friendValue = filteredFriendsDictionary[friendKey] {
            return friendValue.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        
        // Configure the cell...
        let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValue = filteredFriendsDictionary[friendKey] {
            cell.friendNameLabel.text = friendValue[indexPath.row].name
            cell.friendImage.image = friendValue[indexPath.row].image[0]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = tableView.backgroundColor
        view.layer.opacity = 0.5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSectionTitles
    }
    
    
    // MARK: - Transfer image
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            guard let destination = segue.destination as? FriendImagesCollectionVC else { return }
            let selectedCellIndex = self.tableView.indexPathForSelectedRow!.row
            let selectedSection = self.tableView.indexPathForSelectedRow!.section
            
            let friendKey = friendsSectionTitles[selectedSection]
            if let friendValue = filteredFriendsDictionary[friendKey] {
                destination.friendImage = friendValue[selectedCellIndex].image
            }
        }
    }
}