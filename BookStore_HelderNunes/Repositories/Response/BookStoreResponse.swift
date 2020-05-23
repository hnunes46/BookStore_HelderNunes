//
//  BookStoreResponse.swift
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
