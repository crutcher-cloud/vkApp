//
//  SplashViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 03.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet var dots: [AnimatedUIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var delay: Double = 0
        for dot in 0...2 {
            UIView.animate(withDuration: 1, delay: TimeInterval(delay), options: .repeat, animations: {self.dots[dot].opacity -= 10}, completion: nil)
            delay += 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
            self.performSegue(withIdentifier: "stopAnimationSegue", sender: nil)
            self.view!.removeFromSuperview()
        })
    }
    
}

@IBDesignable class AnimatedUIView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    @IBInspectable var opacity: Float {
        set { layer.opacity = newValue / 10}
        get { layer.opacity }
    }
}
