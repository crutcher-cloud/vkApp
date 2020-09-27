//
//  ImageSliderViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 05.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {
    
    var arrayOfImages = [UIImage]()
    var imageIndex = 0
    var friend_id = 21355630
    @IBOutlet weak var friendImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos()

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
    
    func getPhotos() {
        let session = Session.instance
        guard let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(session.token)&owner_id=\(friend_id)&album_id=profile&v=5.124") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }

}
