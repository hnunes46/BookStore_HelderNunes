//
//  BookStoreService.swift
//  BookStore_HelderNunes
//
//  Created by Helder Nunes on 22/05/2020.
//  Copyright © 2020 Helder Nunes. All rights reserved.
//

import Foundation
import Alamofire

class BookStoreService: BaseService {
    internal typealias Response = AFDataResponse<Any>?
    
    
    //MARK: Get books
    
    
    func getBooks(page: Int, completion: @escaping(Response) -> Void) {
        
        AF.request("\(baseURL)?q=ios&maxResults=20&startIndex=\(page)", method: .get).validate().responseJSON { (response) in
            completion(response)
        }
        
    }
}
