//
//  SongModel.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 13/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    var feed: Entry?
}

struct Entry: Decodable {
    var entry: [Items]?
}

struct Items: Decodable {
    
    var songName: Label?
    var artistName: Label?
    var price: PriceStruct?
    var copyRight: Label?
    var songImage: [SongLabel]?
    var videoLink: [VideoURL]?
    
    var category: Category?
    
    private enum CodingKeys: String, CodingKey {
        case songName = "im:name"
        case artistName = "im:artist"
        case price = "im:price"
        case copyRight = "rights"
        case songImage = "im:image"
        case videoLink = "link"
        case category
    }
}

struct Category: Decodable {
    var attributes: NewAttributes?
}

struct NewAttributes: Decodable {
    var label: String?
}

struct PriceStruct: Decodable {
    var label: String?
    var attributes: GetAttributes?
}

struct GetAttributes: Decodable {
    var currency: String?
}

struct VideoURL: Decodable {
    var attributes: NewVideoURL?
}

struct NewVideoURL: Decodable {
    var href: String?
}


struct SongLabel: Decodable {
    var label: String?
}

struct Label: Decodable {
    var label: String?
}





