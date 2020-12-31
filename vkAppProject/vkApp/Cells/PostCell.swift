//
//  PostCell.swift
//  vkApp
//
//  Created by Влад Голосков on 30.12.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var postDateTimeLabel: UILabel!
    
    @IBOutlet weak var newsTextLabel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}