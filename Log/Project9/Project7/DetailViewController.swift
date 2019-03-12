//
//  DetailViewController.swift
//  Project7
//
//  Created by Giulia Boscaro on 06/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; font-family: Arial, sans-serif; text-align: justify} h1 { font-size: 110%; text-align: center } </style>
        </head>
        <body>
        <h1>\(detailItem.title)</h1>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
