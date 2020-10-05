//
//  ImageSliderViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 05.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import Alamofire

class ImageSliderViewController: UIViewController {
    
    var arrayOfImages: [Photo] = []
    var imageIndex = 0
    var friend_id = 0
    @IBOutlet weak var friendImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            let url = URL(string: self.arrayOfImages[self.imageIndex].sizes![4].url!)
            let data = try? Data(contentsOf: url!)
            
            self.friendImage.image = UIImage(data: data!)
        })
        
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
                    let url = URL(string: self.arrayOfImages[self.imageIndex].sizes![4].url!)
                    let data = try? Data(contentsOf: url!)
                    
                    self.friendImage.image = UIImage(data: data!)
                    //self.friendImage.image = self.arrayOfImages[self.imageIndex]
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
                    let url = URL(string: self.arrayOfImages[self.imageIndex].sizes![4].url!)
                    let data = try? Data(contentsOf: url!)
                    
                    self.friendImage.image = UIImage(data: data!)
                    //self.friendImage.image = self.arrayOfImages[self.imageIndex]
                }, completion: nil)

            } else {
                imageIndex -= 1
            }
        default:
            print("Unknown swipe")
        }
    }
    
    func getPhotos() {
        let token = session.token
        let ownerID = friend_id
        let apiVersion = "5.124"

        AF.request("https://api.vk.com/method/photos.getAll?access_token=\(token)&owner_id=\(ownerID)&v=\(apiVersion)").responseData(completionHandler: { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let photos = try JSONDecoder().decode(PhotoListResponse.self, from: data)
                    let photoList = photos.response.items!
                    self.arrayOfImages.append(contentsOf: photoList)
                } catch { print(error) }
            }
        })
    }

}
