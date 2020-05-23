//
//  BooksVC.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import UIKit

class BooksVC: UIViewController {
    var booksCollectionView: UICollectionView!
    var booksDataSource: [Book] = []
    
    var page = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        configureBooksCollectionView()
        getBooks(page: page)
    }
    
    
    private func configureBooksCollectionView() {
        booksCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(booksCollectionView)
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        booksCollectionView.backgroundColor = .systemBackground
        booksCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseId)
    }
    
    
    func getBooks(page: Int) {
        
        NetworkManager.shared.getBooks(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.updateUI(with: books)
            case .failure(let error):
                let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func updateUI(with books: [Book]) {
        booksDataSource.append(contentsOf: books)
        
        DispatchQueue.main.async {
            self.booksCollectionView.reloadData()
        }
    }

}


extension BooksVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookDetailVC = BookDetailVC()
        bookDetailVC.book = booksDataSource[indexPath.row]
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 20
            getBooks(page: page)
        }
    }
    
}


extension BooksVC: UICollectionViewDataSource {
    
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
