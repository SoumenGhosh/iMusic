//
//  TopChartCell.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 13/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class TopChartCell: UITableViewCell {
    
    var item: Items? {
        didSet {
            self.songName.text = item?.songName?.label
            self.artistName.text = item?.artistName?.label
            self.price.text = item?.price?.label
            self.copyRight.text = item?.copyRight?.label
            
            guard var url = item?.songImage?.last?.label else {return}
            url = url.replacingOccurrences(of: "133x100bb", with: "1330x1000bb")
            self.songImage.loadImage(urlString: url)
        }
    }

    let songImage: CustomImageView = {
        let im = CustomImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.layer.cornerRadius = 5
        im.layer.masksToBounds = true
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    let songName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 18)
        return lb
    }()
    
    let artistName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 18)
        return lb
    }()
    
    let price: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 16)
        return lb
    }()
    
    let copyRight: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 14)
        lb.numberOfLines = 2
        return lb
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        setupSongImage()
        setupSongName()
        setupArtistName()
        setupPrice()
        setupCopyRight()
    }
    
    func setupSongImage() {
        addSubview(songImage)
        songImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        songImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        songImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        songImage.widthAnchor.constraint(equalToConstant: frame.width * 0.25).isActive = true
    }
    
    func setupSongName() {
        addSubview(songName)
        songName.leftAnchor.constraint(equalTo: songImage.rightAnchor, constant: 5).isActive = true
        songName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        songName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        songName.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -55).isActive = true
    }
    
    func setupArtistName() {
        addSubview(artistName)
        artistName.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 5).isActive = true
        artistName.leftAnchor.constraint(equalTo: songImage.rightAnchor, constant: 5).isActive = true
        artistName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func setupPrice() {
        addSubview(price)
        price.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        price.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        price.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupCopyRight() {
        addSubview(copyRight)
        copyRight.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 5).isActive = true
        copyRight.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        copyRight.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        copyRight.leftAnchor.constraint(equalTo: songImage.rightAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}










