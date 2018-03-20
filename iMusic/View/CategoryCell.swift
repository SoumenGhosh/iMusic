//
//  CategoryCell.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 18/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var vc: CategoryController?
    
    private let cellID = "cellID"
    var itemsHolder: Feed?
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 20)
        return lb
    }()
    
    let devideLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.alpha = 0.75
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        
        addSubview(booksCollectionView)
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        booksCollectionView.register(SongCell.self, forCellWithReuseIdentifier: cellID)
        
        
        setupCollectionView()
        
        setupCategoryLabel()
        setupDevideLine()
//        callURL()
        
    }
    func setupCollectionView() {
        addSubview(booksCollectionView)
        booksCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        booksCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        booksCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        booksCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
    }
    
    func setupCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
    }
    
    func setupDevideLine() {
        addSubview(devideLine)
        devideLine.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 2).isActive = true
        devideLine.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        devideLine.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        devideLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = center
        addSubview(indicator)
    }
    
    func callURL(url: String) {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        let unrapURL = url
        
        //        guard let unrapURL = myURL else {return}
        guard let urlAct = URL(string: unrapURL) else {return}
        
        URLSession.shared.dataTask(with: urlAct) { (data, response, err) in
            
            guard let data = data else {return}
            do {
                let song = try JSONDecoder().decode(Feed.self, from: data)
                
                DispatchQueue.main.async {
                    self.itemsHolder = song
                    self.booksCollectionView.reloadData()
                }
                
            } catch let jsonErr {
                print("error \(jsonErr)")
            }
        }.resume()
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if categoryLabel.text == "USA" {
            callURL(url: "https://itunes.apple.com/us/rss/topmusicvideos/limit=6/explicit=true/json")
            return 6
        } else if categoryLabel.text == "Canada" {
            callURL(url: "https://itunes.apple.com/ca/rss/topmusicvideos/limit=7/explicit=true/json")
            return 7
        } else if categoryLabel.text == "France" {
            callURL(url: "https://itunes.apple.com/fr/rss/topmusicvideos/limit=5/explicit=true/json")
            return 5
        } else if categoryLabel.text == "South Africa" {
            callURL(url: "https://itunes.apple.com/sa/rss/topmusicvideos/limit=4/explicit=true/json")
            return 4
        } else if categoryLabel.text == "India" {
            callURL(url: "https://itunes.apple.com/in/rss/topmusicvideos/limit=5/explicit=true/json")
            return 5
        }
        callURL(url: "https://itunes.apple.com/au/rss/topmusicvideos/limit=6/explicit=true/json")
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SongCell
        
        if let items = itemsHolder?.feed?.entry {
            let individualFeed = items[indexPath.row]
            cell.item = individualFeed
        }
        
//        print( cell.item?.category?.attributes?.label )
//        print(cell.item?.songName?.label)
//        print(countPop)
        
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: frame.height * 0.25)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("app Selected")
//        let vc = UIViewController()
//        vc.navigationController?.pushViewController(vc, animated: true)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SongCell
        
        if let items = itemsHolder?.feed?.entry {
            let individualFeed = items[indexPath.item]
            cell.item = individualFeed
        
            
            vc?.getSongDetails(songImage: (cell.item?.songImage?.last?.label)!, songName: (cell.item?.songName?.label)!, artistName: (cell.item?.artistName?.label)!, price: (cell.item?.price?.label)!, currency: (cell.item?.price?.attributes?.currency)!, videoURL: (cell.item?.videoLink?.last?.attributes?.href)!, openURL: (cell.item?.videoLink?.first?.attributes?.href)!)
            vc?.showSongDetails()
        }
        
    }
}



class SongCell: UICollectionViewCell {
    
    var item: Items? {
        didSet {
            self.name.text = item?.songName?.label
            
            guard var url = item?.songImage?.last?.label else {return}
            url = url.replacingOccurrences(of: "133x100bb", with: "399x300bb")
            self.songImage.loadImage(urlString: url)
        }
    }
    
    let songImage: CustomImageView = {
        let im = CustomImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.layer.cornerRadius = 5
        im.image = #imageLiteral(resourceName: "music_icon")
        im.layer.masksToBounds = true
        im.backgroundColor = .gray
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    let name: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = UIFont(name: "Times New Roman", size: 16)
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        setupImage()
        setupName()
    }
    
    func setupImage() {
        addSubview(songImage)
        songImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        songImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        songImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        songImage.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
    }
    
    func setupName() {
        addSubview(name)
        name.bottomAnchor.constraint(equalTo: songImage.bottomAnchor, constant: -5).isActive = true
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.leftAnchor.constraint(equalTo: songImage.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        name.rightAnchor.constraint(equalTo: songImage.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



