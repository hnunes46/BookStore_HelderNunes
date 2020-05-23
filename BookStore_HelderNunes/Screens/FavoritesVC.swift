//
//  FavoritesVC.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    var booksCollectionView: UICollectionView!
    var booksDataSource: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBooks()
    }
    
    
    //MARK: UI
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        configureBooksCollectionView()
    }
    
    
    
    private func configureBooksCollectionView() {
        booksCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(booksCollectionView)
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        booksCollectionView.backgroundColor = .systemBackground
        booksCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseId)
    }
    
    
    //MARK: Local Storage
    
    func getBooks() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.updateUI(with: books)
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func updateUI(with books: [Book]) {
        booksDataSource = books
        
        DispatchQueue.main.async {
            self.booksCollectionView.reloadData()
        }
    }

}


extension FavoritesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookDetailVC = BookDetailVC()
        bookDetailVC.book = booksDataSource[indexPath.row]
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
    
}


extension FavoritesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksDataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseId, for: indexPath) as! BookCollectionViewCell
        let book = booksDataSource[indexPath.row]
        cell.set(book: book)
        return cell
    }
}
