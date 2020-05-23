//
//  BSError.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 23/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import Foundation

enum BSError: String, Error {
    case invalidURL         = "This URL is not valid."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
    
}
