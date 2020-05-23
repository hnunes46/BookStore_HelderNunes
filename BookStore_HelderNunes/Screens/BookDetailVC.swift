//
//  BookDetailVC.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 23/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit
import SafariServices

class BookDetailVC: UIViewController {
    let coverImageView      = BSImageView(frame: .zero)
    let titleLabel          = UILabel()
    let authorsLabel        = UILabel()
    let descriptionTextView = UITextView()
    let buyButton           = BSButton()
    
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        configureCoverImageView()
        configureTitleLabel()
        configureAuthorsLabel()
        configureBuyButton()
        configureDescriptionTextView()
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
    
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.text = book.volumeInfo.title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    private func configureAuthorsLabel() {
        view.addSubview(authorsLabel)
        
        authorsLabel.translatesAutoresizingMaskIntoConstraints = false
        authorsLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        authorsLabel.textColor = .secondaryLabel
        authorsLabel.numberOfLines = 0
        authorsLabel.textAlignment = .left
        
        if let authors = book.volumeInfo.authors {
            authorsLabel.text = authors.joined(separator: ", ")
        } else {
            authorsLabel.text = ""
        }
        
        NSLayoutConstraint.activate([
            authorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorsLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            authorsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authorsLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    private func configureBuyButton() {
        view.addSubview(buyButton)
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        
        if let _ = book.saleInfo.buyLink {
            buyButton.set(backgroundColor: .systemGreen, title: "Buy")
        } else {
            buyButton.set(backgroundColor: .systemPink, title: "Book not available")
            buyButton.isEnabled = false
        }
        
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    private func configureDescriptionTextView() {
        view.addSubview(descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionTextView.text = book.volumeInfo.description ?? "No description available."
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -16)
        ])
    }
    
    
    //MARK: Actions
    
    
    @objc private func buyButtonTapped() {
        guard let buyURL = book.saleInfo.buyLink else { return }
        
        if let url = URL(string: buyURL) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        
    }

}
