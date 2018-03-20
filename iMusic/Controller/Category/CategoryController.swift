//
//  CategoryController.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 13/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class CategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    private let largeCellID = "largeCellID"
    
    let songCategory = ["USA", "Canada", "France", "South Africa", "India", "Austraila"]
    var refreshController: UIRefreshControl = UIRefreshControl()
    
    var songImage: String?
    var songName: String?
    var artistName: String?
    var price: String?
    var currency: String?
    var videoURL: String?
    var openURL: String?
    
    func getSongDetails(songImage: String, songName: String, artistName: String, price: String, currency: String, videoURL: String, openURL: String) {
        self.songImage = songImage
        self.songName = songName
        self.artistName = artistName
        self.price = price
        self.currency = currency
        self.videoURL = videoURL
        self.openURL = openURL
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup() {
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(LargeCell.self, forCellWithReuseIdentifier: largeCellID)
        checkNet()
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshController
        } else {
            collectionView?.addSubview(refreshController)
        }
        refreshController.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        
    }
    
    
    @objc func refreshData() {
        collectionView?.reloadData()
        refreshController.endRefreshing()
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 || indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellID, for: indexPath) as! LargeCell
            cell.categoryLabel.text = songCategory[indexPath.item]
            cell.vc = self
            
            
            
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.categoryLabel.text = songCategory[indexPath.item]
        cell.vc = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.25)
    }
    
    
    func showSongDetails() {
//        let vc = UIViewController()
//        navigationController?.pushViewController(vc, animated: true)

        let vc = SongDetailsView()
        
        guard let songImage = self.songImage else {return}
        guard let songName = self.songName else {return}
        guard let artistName = self.artistName else {return}
        guard let price = self.price else {return}
        guard let currency = self.currency else {return}
        guard let videoURL = self.videoURL else {return}
        guard let openURL = self.openURL else {return}
        
        vc.getImageURL(url: songImage, songName: songName, artistName: artistName, price: price, currency: currency, videoURL: videoURL)
        
        let openVc = OpenURLView()
        openVc.getOpenURL(url: openURL)
        navigationController?.pushViewController(vc, animated: true)
//        vc.getImageURL(url: (cell.item?.songImage?.last?.label)!, songName: (cell.item?.songName?.label)!, artistName: (cell.item?.artistName?.label)!, price: (cell.item?.price?.label)!, currency: (cell.item?.price?.attributes?.currency)!, videoURL: (cell.item?.videoLink?.last?.attributes?.href)!)
    }
}

class LargeCell: CategoryCell {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
}












