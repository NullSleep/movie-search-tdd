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
    
    /// API error protocol
    enum APiError : Error {
        case ServiceError(String)
    }
    
    /**
     Given a term and page retunrs a tuple with the JSON respresentation of the response and an Error in case of problems
     */
    func searchTerm(for term: String, page: Int, completion: @escaping (MovieSearchResults?, Error?) -> ()) {
        Alamofire.request(NetworkServicesRouter.serachMovies(term, page)).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                guard let jsonResponse = JSON(rawValue: value) else {
                    let apiError = APiError.ServiceError("JSON response could not be created.")
                    completion(nil, apiError)
                    return
                }
                
                if let errorMessage = jsonResponse["errors"].arrayObject?.first as? String {
                    let apiError = APiError.ServiceError(errorMessage)
                    completion(nil, apiError)
                    return
                }
                
                let movieSearchResults = MovieSearchResults(page: 0, total_results: 0, total_pages: 0, results: [Movie]())
                if let searchResults = movieSearchResults.movieSearchResultsFromReponse(searchResults: jsonResponse) {
                    completion(searchResults, nil)
                }                
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
    
    func searchTermJson(for term: String, page: Int, completion: @escaping (JSON?, Error?) -> ()) {
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
}
