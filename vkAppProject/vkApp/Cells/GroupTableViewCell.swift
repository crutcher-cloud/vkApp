//
//  GroupTableViewCell.swift
//  vkApp
//
//  Created by Влад Голосков on 06.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        groupImage.isUserInteractionEnabled = true
        groupImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickOnImage(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func clickOnImage(_ sender: UITapGestureRecognizer) {
        self.avatarView.transform = .init(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.avatarView.transform = .init(scaleX: 1, y: 1)
        })
    }

}
