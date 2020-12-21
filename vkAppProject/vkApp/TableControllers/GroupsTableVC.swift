//
//  GroupsTableVC.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Firebase


class GroupsTableVC: UITableViewController, UISearchBarDelegate {
    
    var realmToken: NotificationToken?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: Results<Group>?
    
    func pairTableAndRealm() {
        let realm = try! Realm()
        groups = realm.objects(Group.self)
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
    }
    
    func getGroups(completion: @escaping () -> Void) {
        let token = session.token
        let apiVersion = "5.124"
        
        AF.request("https://api.vk.com/method/groups.getCatalog?access_token=\(token)&category_id=0&v=\(apiVersion)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let groups = try JSONDecoder().decode(GroupListResponse.self, from: data)
                    let groupsList = groups.response.items
                    
                    self.saveGroupsData(groups: groupsList!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        completion()
                    })
                } catch { print(error) }
            }
        })
        
    }
    
    func saveGroupsData(groups: [Group]) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(groups, update: .modified)
        }
    }

    func loadGroupsData() {
        do{
            let realm = try Realm()
                self.groups = realm.objects(Group.self)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        // Configure the cell...
        let url = URL(string: groups![indexPath.row].photo!)
        let data = try? Data(contentsOf: url!)
        
        cell.groupImage.image = UIImage(data: data!)
        cell.groupNameLabel.text = groups![indexPath.row].name
        
        return cell
    }
}
