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
    
    /// Api error protocol
    enum APiError : Error {
        case ServiceError(String)
    }
    
    /**
     Given a term and page retunrs a tuple with the JSON respresentation of the response and an Error in case of problems
     */
    func searchTerm(for term: String, page: Int, completion: @escaping (JSON?, Error?) -> ()) {
        Alamofire.request(NetworkServicesRouter.serachMovies(term, page)).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let jsonResponse = JSON(rawValue: value)
                
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
        Alamofire.request(NetworkServicesRouter.serachMovies(term, page)).responseJSON { response in
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
