//
//  BookDetailVC.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 23/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController {
    let coverImageView      = BSImageView(frame: .zero)
    let titleLabel          = UILabel()
    let authorsLabel        = UILabel()
    let descriptionTextView = UITextView()
    let buyButton           = UIButton()
    
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    
    private func configureViewController() {
        configureCoverImageView()
    }
    
    
    private func configureCoverImageView() {
        view.addSubview(coverImageView)
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.downloadImage(fromURL: book.volumeInfo.imageLinks.thumbnail)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            coverImageView.widthAnchor.constraint(equalToConstant: 120),
            coverImageView.heightAnchor.constraint(equalToConstant: 170),
        ])

    }

}
