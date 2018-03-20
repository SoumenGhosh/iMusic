//
//  OpenURLView.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 15/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit
import WebKit

var openURL: String?

class OpenURLView: UIViewController, UIWebViewDelegate {
    func getOpenURL(url: String) {
        openURL = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        navigationItem.title = "iTunes"
        setupURL()
    }
    
    func setupURL() {
        
        guard let url = openURL else {return}
        guard let myURL = URL(string: url) else {return}
        
        let wkWebView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())

        wkWebView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
        wkWebView.load(URLRequest(url: myURL))
        self.view.addSubview(wkWebView)
    }
    
}









