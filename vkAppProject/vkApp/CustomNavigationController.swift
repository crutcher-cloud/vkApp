//
//  CustomNavigationController.swift
//  vkApp
//
//  Created by Влад Голосков on 14.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination as UIViewController
        toViewController.transitioningDelegate = self.transitionManager
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
