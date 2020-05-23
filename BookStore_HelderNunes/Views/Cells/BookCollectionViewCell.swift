//
//  BookCollectionViewCell.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 23/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let reuseId = "BookCell"
    let bookImageView = BSImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(book: Book) {
        bookImageView.downloadImage(fromURL: book.volumeInfo.imageLinks.thumbnail)
    }
    
    
    private func configure() {
        addSubview(bookImageView)
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            bookImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            bookImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
