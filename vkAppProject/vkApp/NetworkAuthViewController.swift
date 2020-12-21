//
//  NetworkAuthViewController.swift
//  vkApp
//
//  Created by Влад Голосков on 27.09.2020.
//  Copyright © 2020 Владислав Голосков. All rights reserved.
//

import UIKit
import WebKit
import Firebase

let session = Session.instance

class NetworkAuthViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "https://oauth.vk.com/authorize?client_id=7610474&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,photos&response_type=token&v=5.124")!)
        webview.load(request)
    }
}

extension NetworkAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        session.token = token!
        
        let userID = params["user_id"]
        session.userId = userID!
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "loginSegue", sender: nil)
        Database.database().reference().child("Users").child("\(userID!)").child("ID").setValue(userID)
    }
}
