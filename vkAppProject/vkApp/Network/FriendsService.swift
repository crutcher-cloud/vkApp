//
//  FriendsService.swift
//  vkApp
//
//  Created by Влад Голосков on 17.01.2021.
//  Copyright © 2021 Владислав Голосков. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

extension FriendsTableViewController {
    class GetFriendsDataOperation: AsyncOperation {
        
        private var request: DataRequest = AF.request("https://api.vk.com/method/friends.get?access_token=\(session.token)&order=name&fields=photo_50&name_case=nom&v=5.124")
        var data: Data?
        
        func saveFriendsData(friends: [User]) {
            let realm = try! Realm()
            try? realm.write {
                realm.add(friends, update: .modified)
            }
        }
        
        override func main() {
            request.responseData(completionHandler: { (response) in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    do{
                        let users = try JSONDecoder().decode(UserListResponse.self, from: data)
                        let friendsList = users.response.items
                        
                        self.saveFriendsData(friends: friendsList!)
                    } catch { print(error.localizedDescription) }
                }
            })
        }
    }
}
