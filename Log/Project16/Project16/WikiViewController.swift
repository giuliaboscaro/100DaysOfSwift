//
//  WikiViewController.swift
//  Project16
//
//  Created by Giulia Boscaro on 02/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    var webView: WKWebView!
    var country: String?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = country else { return }
        
        let url = URL(string: ("https://wikipedia.org/wiki/" + country))
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }

}
