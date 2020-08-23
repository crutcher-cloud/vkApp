//
//  FriendsTableViewCell.swift
//  vkApp
//
//  Created by Влад Голосков on 05.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell { 
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
