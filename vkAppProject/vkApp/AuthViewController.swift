//
//  ViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 30.07.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Email или телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 171, green: 174, blue: 179, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 171, green: 174, blue: 179, alpha: 1)])
        
        loginButton.layer.cornerRadius = 10
        registrationButton.layer.cornerRadius = 10
        
        loginButton.backgroundColor = UIColor(displayP3Red: 226, green: 227, blue: 231, alpha: 1)
        registrationButton.backgroundColor = UIColor(displayP3Red: 226, green: 227, blue: 231, alpha: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

