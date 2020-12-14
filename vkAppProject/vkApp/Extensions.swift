//
//  Extensions.swift
//  vkApp
//
//  Created by Влад Голосков on 07.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CGColor {
    var UIColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}

//extension FriendsTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        friendsSectionTitles = []
//        filteredFriendsDictionary = [:]
//        var filteredFriends = [User]() //Массив результата поиска
//
//        let friendKey = String(searchText.first ?? "?")
//
//        if friendKey != "?" {
//            friendsSectionTitles.append(friendKey)
//        } else {
//            friendsSectionTitles = [String] (friendsDictionary.keys)
//            friendsSectionTitles = friendsSectionTitles.sorted(by: {$0 < $1})
//
//            filteredFriendsDictionary = friendsDictionary
//        }
//
//        Заполнение результата поиска.
//        for friend in friends {
//            if friend.lastName!.prefix(searchText.count).contains(searchText) {
//                filteredFriends.append(friend)
//                filteredFriendsDictionary[friendKey] = filteredFriends
//            }
//        }
//
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        filteredFriendsDictionary = friendsDictionary
//
//        friendsSectionTitles = [String] (friendsDictionary.keys)
//        friendsSectionTitles = friendsSectionTitles.sorted(by: {$0 < $1})
//
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//
//        tableView.reloadData()
//    }

