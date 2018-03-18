//
//  NetworkServices.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/16/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkServices {
    
    enum APiError : Error {
        case ServiceError(String)
    }
    
    // API constants
    let apiUrl = "http://api.themoviedb.org"
    let apiEndPoint = "/3/search/movie"
    let api_key = "ab7af61e73ec7d42ab86366c0e1374e9"
    
    /**
     Given a term and page retunrs a tuple with the JSON respresentation of the response and an Error in case of problems
     */
    func searchTerm(for term: String, page: Int, completion: @escaping (JSON?, Error?) -> ()) {
        
        let parameters: Parameters = ["query": term, "page": page, "api_key": self.api_key]
        print(parameters)
        let url = self.apiUrl + self.apiEndPoint
        
        Alamofire.request(url, method: .get, parameters:parameters).responseJSON { response in
            switch response.result {
                
            case .success(let value):

                let jsonResponse = JSON(rawValue: value)
                print(jsonResponse?["errors"][0].string ?? "UUU")
                
                if let errorMessage = jsonResponse?["errors"].arrayObject?.first as? String {
                    let apiError = APiError.ServiceError(errorMessage)
                    completion(nil, apiError)
                    return
                }
                
                completion(jsonResponse, nil)
                
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
    
    func BASICSearch(for term: String, page: Int, completion: @escaping (JSON?, Error?) -> ()) {
        let parameters: Parameters = ["query": term, "page": page, "api_key": self.api_key]
        print(parameters)
        let url = self.apiUrl + self.apiEndPoint
        
        Alamofire.request(url, method: .get, parameters:parameters).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let jsonResponse = JSON(rawValue: value)
                completion(jsonResponse, nil)
                
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
}
