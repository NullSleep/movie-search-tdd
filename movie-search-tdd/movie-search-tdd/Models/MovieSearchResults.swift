//
//  MovieSearchResults.swift
//  movie-search
//
//  Created by Carlos Arenas on 3/12/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieSearchResults {
    
    // MARK: - Properties
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    var results: [Movie]?
    var isEmpty : Bool {
        return results?.isEmpty ?? true
    }

    // MARK: - Public functions
    
    /**
     Function to parse the response from the API Call given a JSON strucutre and convert it to MovieSearchResults
     */
    func movieSearchResultsFromReponse(searchResults: JSON) -> MovieSearchResults? {
        var searchResult: MovieSearchResults?
        
        if let page = searchResults["page"].int,
            let total_results = searchResults["total_results"].int,
            let total_pages = searchResults["total_pages"].int,
            let results = searchResults["results"].array {
            
            var movies = [Movie]()
            
            // Go through every movie and append it to movies dictionary
            for movieObject in results {
                let movie = Movie(moviePoster: movieObject["poster_path"].string,
                                  movieName: movieObject["original_title"].string,
                                  releaseDate: movieObject["release_date"].string,
                                  movieOverview: movieObject["overview"].string)
                movies.append(movie)
                
            }
        
            searchResult = MovieSearchResults(page: page, total_results: total_results, total_pages: total_pages, results: movies)
        }
        
        return searchResult
    }
}
