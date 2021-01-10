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
    
    var realmToken: NotificationToken?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var friendsDictionary: [String: Results<User>?] = [:]
    var friendsSectionTitles = [String]()

    var friends: Results<User>?
    
    //var filteredFriendsDictionary: [String: Results<User>?] = [:] //Словарь друзей, использующийся для поиска
    
    func pairTableAndRealm() {
        let realm = try! Realm()
        friends = realm.objects(User.self)
        realmToken = friends!.observe { [weak self] (changes: RealmCollectionChange) in
                    guard let tableView = self?.tableView else { return }
                    switch changes {
                    case .initial:
                        tableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        tableView.beginUpdates()
                        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                             with: .automatic)
                        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                        tableView.endUpdates()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        //searchBar.delegate = self
        
        getFriends(completion: self.loadFriendsData)
        pairTableAndRealm()
        
        debugPrint("Token: \(session.token)")
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
            self.friends = realm.objects(User.self)
            
            //Заполнение словаря с друзьями в формате "первая буква" : [друзья]
//            for friend in friends! {
//                let friendKey = String(friend.lastName!.prefix(1))
//                if var friendValues = self.friendsDictionary[friendKey] {
//                    friendValues.append(friend)
//                    self.friendsDictionary[friendKey] = friendValues
//                } else {
//                    self.friendsDictionary[friendKey] = [friend]
//                }
//            }

            //self.filteredFriendsDictionary = self.friendsDictionary

            //self.friendsSectionTitles = [String] (self.friendsDictionary.keys)
            //self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {$0 < $1})

            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return friends!.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        
        // Configure the cell...
        let url = URL(string: friends![indexPath.row].photo!)
        let data = try? Data(contentsOf: url!)
            
            cell.friendNameLabel.text = "\(friends![indexPath.row].firstName!) \(friends![indexPath.row].lastName!)"
            cell.friendImage.image = UIImage(data: data!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = tableView.backgroundColor
        view.layer.opacity = 0.5
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return friendsSectionTitles[section]
//    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return friendsSectionTitles
//    }
    
    
    // MARK: - Transfer image
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            guard let destination = segue.destination as? ImageSliderViewController else { return }
            let selectedCellIndex = self.tableView.indexPathForSelectedRow!.row
            //let selectedSection = self.tableView.indexPathForSelectedRow!.section
            
            destination.friend_id = friends![selectedCellIndex].id
        }
    }
}
