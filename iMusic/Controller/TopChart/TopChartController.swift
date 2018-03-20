//
//  TopChartController.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 13/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

var myURL: String?
var myCount = 0

class TopChartController: UITableViewController {
    
    private let cellID = "cellID"
    var itemsHolder: Feed?
    var refreshController: UIRefreshControl = UIRefreshControl()
    
    func getActualURL(url: String, count: Int) {
        myURL = url
        myCount = count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        tableView.backgroundColor = .white
        tableView.register(TopChartCell.self, forCellReuseIdentifier: cellID)
        
        checkNet()
        callURL()
        setupReload()
    }
    
    func setupReload() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
        } else {
            tableView.addSubview(refreshController)
        }
        refreshController.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
    }
    
    
    @objc func refreshData() {
        callURL()
        tableView.reloadData()
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
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    func callURL() {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        var unrapURL = ""
        if myCount == 0 {
            unrapURL = "https://itunes.apple.com/ca/rss/topmusicvideos/limit=100/explicit=true/json"
        } else {
            unrapURL = myURL!
        }
        guard let urlAct = URL(string: unrapURL) else {return}
        
        URLSession.shared.dataTask(with: urlAct) { (data, response, err) in
            
            guard let data = data else {return}
            do {
                let song = try JSONDecoder().decode(Feed.self, from: data)

                DispatchQueue.main.async {
                    self.itemsHolder = song
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("error is \(jsonErr)")
            }
        }.resume()
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TopChartCell

        if let items = itemsHolder?.feed?.entry {
            let individualFeed = items[indexPath.row]
            cell.item = individualFeed
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = itemsHolder?.feed?.entry?.count {
            return count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TopChartCell
        
        if let items = itemsHolder?.feed?.entry {
            let individualFeed = items[indexPath.row]
            cell.item = individualFeed
            let vc = SongDetailsView()
            vc.getImageURL(url: (cell.item?.songImage?.last?.label)!, songName: (cell.item?.songName?.label)!, artistName: (cell.item?.artistName?.label)!, price: (cell.item?.price?.label)!, currency: (cell.item?.price?.attributes?.currency)!, videoURL: (cell.item?.videoLink?.last?.attributes?.href)!)
            
            let openVC = OpenURLView()
            openVC.getOpenURL(url: (cell.item?.videoLink?.first?.attributes?.href)!)
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}










