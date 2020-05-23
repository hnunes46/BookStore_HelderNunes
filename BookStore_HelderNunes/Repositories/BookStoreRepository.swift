//
//  BookStoreRepository.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import Foundation

class BookStoreRepository {
    let service = BookStoreService()
    
    func getBooks(page: Int, success: @escaping([Book]) -> Void, failure: @escaping(String) -> Void) {
        
        service.getBooks(page: page) { (response) in
            print(String(decoding: response!.data!, as: UTF8.self))
            switch(response!.result) {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let booksResponse = try decoder.decode(BookStoreResponse.self, from: response!.data!)
                    
                    if let books = booksResponse.items {
                        success(books)
                    } else {
                        failure("No books available")
                    }
                    
                } catch (let error) {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
