//
//  OpenURLView.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 15/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit
var openURL: String?
class OpenURLView: UIViewController, UIWebViewDelegate {
    
    
    
    func getOpenURL(url: String){
        openURL = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        print(openURL)
    }
    
    
    func setup() {
        view.backgroundColor = .white
        setupURL()
    }
    
    func setupURL() {
//        print(openURL)
        
        let myWebView:UIWebView = UIWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.view.addSubview(myWebView)
        myWebView.delegate = self
        
//        guard let url = openURL else {return}
        let url = "https://itunes.apple.com/ca/music-video/zombie-official-video/1357806798?uo=2"
        guard let myURL = URL(string: url) else {return}
        print("this is \(myURL)")
        let myURLRequest: URLRequest = URLRequest(url: myURL)
        myWebView.loadRequest(myURLRequest)
    }
    
}









