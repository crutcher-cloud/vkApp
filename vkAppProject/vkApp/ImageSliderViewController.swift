//
//  ImageSliderViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 05.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {
    
    let transitionManager = TransitionManager()
    
    var arrayOfImages = [UIImage]()
    var imageIndex = 0
    @IBOutlet weak var friendImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendImage.image = arrayOfImages[imageIndex]
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        friendImage.isUserInteractionEnabled = true
        friendImage.addGestureRecognizer(rightSwipe)
        friendImage.addGestureRecognizer(leftSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            imageIndex -= 1
            if imageIndex >= 0 {
                UIView.animate(withDuration: 0.7, animations: {
                    self.friendImage.transform = .init(scaleX: 1, y: 1)
                })
                UIView.transition(with: self.friendImage, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.friendImage.image = self.arrayOfImages[self.imageIndex]
                }, completion: nil)
            } else {
                imageIndex += 1
            }
        case .left:
            imageIndex += 1
            if imageIndex <= arrayOfImages.count - 1 {
                UIView.animate(withDuration: 0.7, animations: {
                    self.friendImage.transform = .init(scaleX: 0.9, y: 0.9)
                })
                UIView.transition(with: self.friendImage, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.friendImage.image = self.arrayOfImages[self.imageIndex]
                }, completion: nil)
                
            } else {
                imageIndex -= 1
            }
        default:
            print("Unknown swipe")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let toViewController = segue.destination as UIViewController
               toViewController.transitioningDelegate = self.transitionManager
    }
}
