//
//  TransitionManager.swift
//  vkApp
//
//  Created by Влад Голосков on 14.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var presenting = true
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let π = CGFloat(Double.pi)
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
        
        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
        
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
            if self.presenting {
                fromView.transform = offScreenRotateOut
            } else {
                fromView.transform = offScreenRotateIn
            }
            toView.transform = CGAffineTransform.identity
        }, completion: { (finished) -> Void in
            transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
