//
//  GroupsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {
    var groups = [
        Group(image: (UIImage(named: "GeekBrains") ?? UIImage(named: "logo"))!, name: "GeekBrains")
    ]
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let groupsController = segue.source as? GroupsTableVC else { return }
            if let indexPath = groupsController.tableView.indexPathForSelectedRow {
                let newGroup = groupsController.groups[indexPath.row]
                let existenceCheck = groups.contains { (userGroup) -> Bool in
                    userGroup.name == newGroup.name
                }
                
                if !existenceCheck {
                    groups.append(newGroup)
                    tableView.reloadData()
                } else {
                    showAlert(title: "Ошибка", message: "Данная группа уже есть в списке групп пользователя!", buttonText: "Продолжить")
                }
            }
        }
    }
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as! GroupTableViewCell
        
        cell.groupImage.image = groups[indexPath.row].image
        cell.groupNameLabel.text = groups[indexPath.row].name
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

