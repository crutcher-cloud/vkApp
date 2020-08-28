//
//  CustomLikeControl.swift
//  vkApp
//
//  Created by Влад Голосков on 26.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

@IBDesignable class CustomLikeControl: UIView {

    @IBInspectable var opacity: Float {
        set { layer.opacity = newValue / 10 }
        get { layer.opacity }
    }
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeCountLabel: UILabel!
    
    var likeCount: Int = 0
    var buttonStatus: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func likeButtonTap(_ sender: UIButton) {
        if buttonStatus {
            likeCount -= 1
            likeCountLabel.text = "\(likeCount)"
            sender.setImage(UIImage(named: "unselectedHeart"), for: .normal)
            likeCountLabel.textColor = .black
        } else {
            likeCount += 1
            likeCountLabel.text = "\(likeCount)"
            sender.setImage(UIImage(named: "selectedHeart"), for: .normal)
            likeCountLabel.textColor = .red
        }
        
        buttonStatus = !buttonStatus
    }
}
