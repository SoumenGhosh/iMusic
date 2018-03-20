//
//  SideBarController.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 16/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class SideBarController: UIViewController {
    
    let countryText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "enter country"
        
        tf.textAlignment = .center
        tf.keyboardType = .default
        tf.keyboardAppearance = .dark
        
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        return tf
    }()
    
    let countText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "1-100"
        
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.keyboardAppearance = .dark
        
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        return tf
    }()
    
    let searchBut: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Search", for: .normal)
        bt.backgroundColor = .black
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(butHit), for: .touchUpInside)
        return bt
    }()
    
    @objc func butHit() {
        print(2)
        guard var country = countryText.text else {return}
        guard let count = countText.text else {return}
        
        if country == "" {
            alert(result: "No country name found")
        } else {
            country = country.lowercased()
        }
        
        let countNum = Int(count)
        if count == "" || countNum == 0 {
            alert(result: "No Count found")
        }
        
        let myURL = "https://itunes.apple.com/\(country)/rss/topmusicvideos/limit=\(count)/explicit=true/json"
        print(myURL)
//        let vc = TopChartController()
//        vc.getActualURL(url: myURL)
//        vc.viewDidLoad()
        
    }
    
    // alert
    func alert(result: String){
        let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        setupTap()
        setupCountry()
        setupCount()
        setupBut()
    }
    
    func setupTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    func setupCountry() {
        view.addSubview(countryText)
        countryText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        countryText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        countryText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        countryText.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupCount() {
        view.addSubview(countText)
        countText.topAnchor.constraint(equalTo: countryText.bottomAnchor, constant: 15).isActive = true
        countText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        countText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        countText.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupBut() {
        view.addSubview(searchBut)
        searchBut.topAnchor.constraint(equalTo: countText.bottomAnchor, constant: 15).isActive = true
        searchBut.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        searchBut.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        searchBut.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}





















