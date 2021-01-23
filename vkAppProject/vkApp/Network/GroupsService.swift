//
//  GroupsService.swift
//  vkApp
//
//  Created by Влад Голосков on 23.01.2021.
//  Copyright © 2021 Владислав Голосков. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import PromiseKit

extension GroupsTableVC {
    func loadGroupsData() -> Promise<[Group]> {
        let token = session.token
        let apiVersion = "5.124"
        
        return Promise { seal in
            AF.request("https://api.vk.com/method/groups.getCatalog?access_token=\(token)&category_id=0&v=\(apiVersion)").responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let groups = try JSONDecoder().decode(GroupListResponse.self, from: data)
                        self.groupsList = groups.response.items!
                        
                        self.saveGroupsData(groups: self.groupsList)
                        seal.fulfill(self.groupsList)
                    } catch { print(error) }
                case .failure:
                    seal.reject(response.error!)
                }
            })
        }
    }
    
    func getGroups() {
        firstly {
            loadGroupsData()
        }.ensure {
            if !self.realm.isEmpty {
                self.loadGroupsDataFromRealm()
            } else {
                self.tableView.reloadData()
            }
            print("Groups loaded successfully!")
        }.catch { error in
            print(error)
        }
    }
}
