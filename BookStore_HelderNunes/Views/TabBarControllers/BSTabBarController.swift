//
//  BSTabBarController.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class BSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemPink
        viewControllers = [createBooksNC(), createFavoritesNC()]
    }
    
    
    private func createBooksNC() -> UINavigationController {
        let booksVC = BooksVC()
        booksVC.title = "Book Store"
        booksVC.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book.fill"), tag: 0)
        
        return UINavigationController(rootViewController: booksVC)
    }
    
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
}
