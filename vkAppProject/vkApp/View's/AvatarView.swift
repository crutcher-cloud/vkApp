//
//  AvatarView.swift
//  vkApp
//
//  Created by Влад Голосков on 16.08.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class AvatarView: UIView {
    @IBInspectable var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor }
        get { return layer.shadowColor?.UIColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue / 10 }
        get { layer.shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue }
        get { layer.shadowRadius }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
}
