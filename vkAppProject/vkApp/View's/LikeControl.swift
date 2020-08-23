//
//  LikeControl.swift
//  vkApp
//
//  Created by Влад Голосков on 23.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

@IBDesignable class likeControl: UIControl {
    
    var buttonStatus: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        let heartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        heartButton.setImage(UIImage(named: "unselectedHeart"), for: .normal)
        heartButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        
        self.addSubview(heartButton)
    }
    
    @objc private func buttonClick(_ sender: UIButton) {
        
        if buttonStatus {
            sender.setImage(UIImage(named: "unselectedHeart"), for: .normal)
            //FriendImagesCollectionCell.countLabel.text = "0"
        } else {
            sender.setImage(UIImage(named: "selectedHeart"), for: .normal)
        }
        buttonStatus = !buttonStatus
    }
}
