//
//  Book.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import Foundation

struct BookStoreResponse: Codable {
    var kind: String
    var totalItems: Int
    var items: [Book]?
}

struct Book: Codable, Equatable {
    var id: String
    var volumeInfo: VolumeInfo
    var saleInfo: SaleInfo
    
}


struct VolumeInfo: Codable, Equatable {
    var title: String
    var authors: [String]?
    var description: String?
    var imageLinks: ImageLinks?
}


struct SaleInfo: Codable, Equatable {
    var buyLink: String?
}


struct ImageLinks: Codable, Equatable {
    var thumbnail: String
}
