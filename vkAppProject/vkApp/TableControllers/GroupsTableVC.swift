//
//  GroupsTableVC.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import Alamofire


class GroupsTableVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getGroups() {
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
                    self.groups = groupsList!
                    
                    print(groupsList![0])
                } catch { print(error) }
            }
        })
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if groups.count != 0 {
            return groups.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        // Configure the cell...
        let url = URL(string: groups[indexPath.row].photo!)
        let data = try? Data(contentsOf: url!)
        
        cell.groupImage.image = UIImage(data: data!)
        cell.groupNameLabel.text = groups[indexPath.row].name
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
