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
    
    class AsyncOperation: Operation {
        enum State: String {
            case ready, executing, finished
            fileprivate var keyPath: String {
                return "is" + rawValue.capitalized
            }
        }
        
        var state = State.ready {
            willSet {
                willChangeValue(forKey: state.keyPath)
                willChangeValue(forKey: newValue.keyPath)
            }
            didSet {
                didChangeValue(forKey: state.keyPath)
                didChangeValue(forKey: oldValue.keyPath)
            }
        }
        
        override var isAsynchronous: Bool {
            return true
        }
        
        override var isExecuting: Bool {
            return state == .executing
        }
        
        override var isFinished: Bool {
            return state == .finished
        }
        
        override func start() {
            if isCancelled {
                state = .finished
            } else {
                main()
                state = .executing
            }
        }
        
        override func cancel() {
            super.cancel()
            state = .finished
        }
    }
}

extension CGColor {
    var UIColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}

extension Dictionary {
    mutating func merge(other:Dictionary) {
        for (key,value) in other {
          self.updateValue(value, forKey:key)
        }
      }
}

extension String {
    func toImage() -> UIImage? {
        let url = URL(string: self)
        let data = try? Data(contentsOf: url!)
        
        let image = UIImage(data: data!)
        return image
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

