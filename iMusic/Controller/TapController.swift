//
//  TapController.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 13/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITextFieldDelegate {
    
    let myView: UIView = {
        let mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.layer.cornerRadius = 5
        mv.layer.masksToBounds = true
        mv.backgroundColor = .black
        mv.alpha = 0.75
        return mv
    }()
    
    let goBut: UIButton = {
        let go = UIButton()
        go.translatesAutoresizingMaskIntoConstraints = false
        go.setTitle("GO!", for: .normal)
        go.layer.masksToBounds = true
        go.layer.cornerRadius = 5
//        go.backgroundColor = .black
        go.addTarget(self, action: #selector(goHit), for: .touchUpInside)
        return go
    }()
    
    let cancelBut: UIButton = {
        let go = UIButton()
        go.translatesAutoresizingMaskIntoConstraints = false
        go.setTitle("Cancel!", for: .normal)
        go.layer.masksToBounds = true
        go.layer.cornerRadius = 5
        go.addTarget(self, action: #selector(cancelHit), for: .touchUpInside)
        return go
    }()

    @objc func cancelHit() {
        myView.isHidden = true
        countText.text = ""
        countryText.text = ""
    }
    
    
    let countryText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.placeholder = "enter country"
        tf.textColor = .white
        tf.textAlignment = .center
        tf.keyboardType = .default
        tf.keyboardAppearance = .dark
        
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        
        var myMutableStringTitle = NSMutableAttributedString()
        let name = "Enter Country"
        
        myMutableStringTitle = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0)!]) // Font
        myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range:NSRange(location:0, length: name.characters.count))    // Color
        tf.attributedPlaceholder = myMutableStringTitle
        
        
        return tf
    }()
    
    let countText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.keyboardAppearance = .dark
        
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        
        var myMutableStringTitle = NSMutableAttributedString()
        let name = "1-100"
        
        myMutableStringTitle = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0)!]) // Font
        myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range:NSRange(location:0, length: name.characters.count))    // Color
        tf.attributedPlaceholder = myMutableStringTitle
        return tf
    }()
    
    @objc func goHit() {
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
//        print(myURL)
        
        let vc = TopChartController()
        vc.getActualURL(url: myURL, count: 1)
        if country != "" && count != "" && countNum != 0 {
            myView.isHidden = true
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        checkNet()
        setupTab()
        setupNav()
        setupMyView()
        setupGoBut()
        setupCancelBut()
        setupCount()
        setupCountry()
//        setupTap()
        myView.isHidden = true
        countryText.delegate = self
        countText.delegate = self
        
        navigationItem.title = "Category Songs"
    }
    
    func checkNet() {
        if Reachability.isConnectedToNetwork() {}
        else{
            alert(result: "Internet Connection not Available!")
        }
    }
    
    // alert
    func alert(result: String){
        let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    // works to do
    func setupNav() {
        navigationItem.title = "Top Chart"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        
    }
    
    
    
    @objc func showSearch() {
        myView.isHidden = false
    }
    
    
    func setupTab() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 15, right: 15)
//        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        
        let firstViewController = CategoryController(collectionViewLayout: layout)
        firstViewController.tabBarItem.image =  #imageLiteral(resourceName: "categorySong")
        firstViewController.tabBarItem.title = "Category Songs"
        
        let secondViewController = TopChartController()
        secondViewController.tabBarItem.image = #imageLiteral(resourceName: "t") // image is here
        secondViewController.tabBarItem.title = "Top Rated"
        
        viewControllers = [firstViewController, secondViewController]
        
    }
    
    func setupMyView() {
        view.addSubview(myView)
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        myView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func setupCountry() {
        myView.addSubview(countryText)
        countryText.topAnchor.constraint(equalTo: countText.bottomAnchor, constant: 15).isActive = true
        countryText.leftAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        countryText.rightAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        countryText.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupCount() {
        myView.addSubview(countText)
        countText.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        countText.leftAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        countText.rightAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        countText.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupGoBut() {
        myView.addSubview(goBut)
        goBut.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -5).isActive = true
        goBut.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 10).isActive = true
        goBut.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupCancelBut() {
        myView.addSubview(cancelBut)
        cancelBut.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -5).isActive = true
        cancelBut.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -10).isActive = true
        cancelBut.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let indexOfTab = tabBar.items?.index(of: item) else { return }
        
        if indexOfTab == 0 {
            navigationItem.title = "Category Songs"
        } else {
            navigationItem.title = "Top Chart"
        }
    }
}
