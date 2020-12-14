//
//  UserGroupsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class UserGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var realmToken: NotificationToken?
    
    var groups: Results<UserGroup>?
    
    //var filteredGroups: Results<UserGroup>?
    
    func pairTableAndRealm() {
        let realm = try! Realm()
        groups = realm.objects(UserGroup.self)
        realmToken = groups!.observe { [weak self] (changes: RealmCollectionChange) in
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
        
        getGroups(completion: self.loadGroupsData)
        pairTableAndRealm()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
//            self.filteredGroups = self.groups
//
//            self.tableView.reloadData()
//        })
    }
    
    func getGroups(completion: @escaping () -> Void) {
        let token = session.token
        let userID = session.userId
        let extended = 1
        let apiVersion = "5.124"
        
        AF.request("https://api.vk.com/method/groups.get?access_token=\(token)&user_id=\(userID)&extended=\(extended)&v=\(apiVersion)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let groups = try JSONDecoder().decode(UserGroupListResponse.self, from: data)
                    let groupsList = groups.response.items
                    
                    self.saveGroupsData(groups: groupsList!)
                    completion()
                } catch { print(error) }
            }
        })
        
    }
    
    func saveGroupsData(groups: [UserGroup]) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(groups, update: .modified)
        }
    }
    
    func loadGroupsData() {
        do{
            let realm = try Realm()
            self.groups = realm.objects(UserGroup.self)
        
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as! GroupTableViewCell
        
        let url = URL(string: groups![indexPath.row].photo!)
        let data = try? Data(contentsOf: url!)
        
        cell.groupImage.image = UIImage(data: data!)
        cell.groupNameLabel.text = groups![indexPath.row].name
        
        return cell
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // When there is no text, filteredData is the same as the original data
//        // When user has entered text into the search box
//        // Use the filter method to iterate over all items in the data array
//        // For each item, return true if the item should be included and false if the
//        // item should NOT be included
//        filteredGroups = searchText.isEmpty ? groups : groups.filter({(dataString: UserGroup) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataString.name!.range(of: searchText, options: .caseInsensitive) != nil
//            //dataString.range(of: searchText, options: .caseInsensitive) != nil
//        })
//
//        tableView.reloadData()
//    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            groups.remove(at: indexPath.row)
//            filteredGroups = groups
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            //tableView.reloadData()
//        }
//    }
}

