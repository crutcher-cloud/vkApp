//
//  FriendsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsDictionary: [String: [User]] = [:]
    var friendsSectionTitles = [String]()

    var friends: [User] = []
    
    var filteredFriendsDictionary: [String: [User]] = [:] //Словарь друзей, использующийся для поиска
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        getFriends(completion: self.loadFriendsData)
    }
    
    func getFriends(completion: @escaping () -> Void) {
        let token = session.token
        let order = "name"
        let fields = "photo_50"
        let nameCase = "nom"
        let apiVersion = "5.124"

        AF.request("https://api.vk.com/method/friends.get?access_token=\(token)&order=\(order)&fields=\(fields)&name_case=\(nameCase)&v=\(apiVersion)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                do{
                    let users = try JSONDecoder().decode(UserListResponse.self, from: data)
                    let friendsList = users.response.items
                    
                    self.saveFriendsData(friends: friendsList!)
                    completion()
                } catch { print(error.localizedDescription) }
            }
        })
    }
    
    func saveFriendsData(friends: [User]) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(friends, update: .modified)
        }
    }
    
    func loadFriendsData() {
        do {
            let realm = try Realm()
            self.friends = Array(realm.objects(User.self))
            
            //Заполнение словаря с друзьями в формате "первая буква" : [друзья]
            for friend in self.friends {
                let friendKey = String(friend.lastName!.prefix(1))
                if var friendValues = self.friendsDictionary[friendKey] {
                    friendValues.append(friend)
                    self.friendsDictionary[friendKey] = friendValues
                } else {
                    self.friendsDictionary[friendKey] = [friend]
                }
            }

            self.filteredFriendsDictionary = self.friendsDictionary

            self.friendsSectionTitles = [String] (self.friendsDictionary.keys)
            self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {$0 < $1})

            self.tableView.reloadData()
        } catch {
            print(error)
        }
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
            let url = URL(string: friendValue[indexPath.row].photo!)
            let data = try? Data(contentsOf: url!)
            
            cell.friendNameLabel.text = "\(friendValue[indexPath.row].firstName!) \(friendValue[indexPath.row].lastName!)"
            cell.friendImage.image = UIImage(data: data!)
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
            guard let destination = segue.destination as? ImageSliderViewController else { return }
            let selectedCellIndex = self.tableView.indexPathForSelectedRow!.row
            let selectedSection = self.tableView.indexPathForSelectedRow!.section
            
            let friendKey = friendsSectionTitles[selectedSection]
            if let friendValue = filteredFriendsDictionary[friendKey] {
                destination.friend_id = friendValue[selectedCellIndex].id
            }
        }
    }
}
