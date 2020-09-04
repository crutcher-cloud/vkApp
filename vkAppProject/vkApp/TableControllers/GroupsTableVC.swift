//
//  GroupsTableVC.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit


class GroupsTableVC: UITableViewController {
    
    var groups = [
        Group(image: (UIImage(named: "GeekBrains") ?? UIImage(named: "logo"))!, name: "GeekBrains"),
        Group(image: (UIImage(named: "2ch") ?? UIImage(named: "logo"))!, name: "2ch"),
        Group(image: (UIImage(named: "Meduza") ?? UIImage(named: "logo"))!, name: "Медуза")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        // Configure the cell...
        cell.groupImage.image = groups[indexPath.row].image
        cell.groupNameLabel.text = groups[indexPath.row].name
        
        return cell
    }
}
