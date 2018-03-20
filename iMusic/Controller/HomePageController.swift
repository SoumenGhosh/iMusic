//
//  HomePageController.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 11/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    let gradienImage: UIImageView = {
        let gi = UIImageView()
        gi.translatesAutoresizingMaskIntoConstraints = false
        gi.image = #imageLiteral(resourceName: "gradians")
        gi.contentMode = .scaleAspectFill
        gi.layer.masksToBounds = true
        return gi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .red
        navigationItem.title = "Songs"
        
//        setupGradienImage()
//        setupAnimated()
    }
    
    func setupGradienImage() {
        view.addSubview(gradienImage)
        gradienImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        gradienImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        gradienImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        gradienImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        gradienImage.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        gradienImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupAnimated() {
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            let x = -(self.gradienImage.frame.width - self.view.frame.width)
            self.gradienImage.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    
}













