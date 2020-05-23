//
//  BooksVC.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class BooksVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        let repository = BookStoreRepository()
        
        repository.getBooks(page: 0, success: { (books) in
            print(books)
        }) { (error) in
            print(error)
        }
    }

}
