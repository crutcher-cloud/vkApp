//
//  UserGroupsTableViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class UserGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups = [
        Group(image: (UIImage(named: "GeekBrains") ?? UIImage(named: "logo"))!, name: "GeekBrains")
    ]
    
    var filteredGroups: [Group]!
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let groupsController = segue.source as? GroupsTableVC else { return }
            if let indexPath = groupsController.tableView.indexPathForSelectedRow {
                let newGroup = groupsController.groups[indexPath.row]
                if !self.groups.contains(where: {g -> Bool in
                    g.name == newGroup.name
                }) {
                    self.groups.append(newGroup)
                    filteredGroups = groups
                    tableView.reloadData()
                } else {
                    showAlert(title: "Ошибка", message: "Данная группа уже есть в списке групп пользователя!", buttonText: "Продолжить")
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups()
        
        tableView.dataSource = self
        searchBar.delegate = self
        filteredGroups = groups
    }
    
    func getGroups() {
        let session = Session.instance
        guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(session.token)&extended=1&v=5.124") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as! GroupTableViewCell
        
        cell.groupImage.image = filteredGroups[indexPath.row].image
        cell.groupNameLabel.text = filteredGroups[indexPath.row].name
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredGroups = searchText.isEmpty ? groups : groups.filter({(dataString: Group) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.name.range(of: searchText, options: .caseInsensitive) != nil
            //dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            filteredGroups = groups
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //tableView.reloadData()
        }
    }
}

