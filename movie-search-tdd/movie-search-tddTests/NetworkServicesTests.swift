//
//  NetworkServicesTests.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/16/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd

/// Network services tess for the movie search API endpoints.
class NetworkServicesTests: XCTestCase {
    
    /// Singleton for handling NetworkServices requests
    let networkServices = NetworkServices()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     This fucntion tests the API search endpoint for a success answer disregarding the data
     */
    func getSearchResultsForRandomMovieTest() {
        
        XCTAssertEqual(result, true)
        
        let e = expectation(description: "NetworkServices Search API")
        
//        XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
//        XCTAssertNotNil(response, "No response")
//        XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
        
        networkServices.performSearch(for: "batman", page: 1) {
            movieData, error in
            
            var jsonValue: JSON = [:] {
                didSet {
                    self.createMovies(json: jsonValue, page: self.currentPage)
                }
            }
            
            if movieData != nil {
                self.searchActive = false;
                
                jsonValue = movieData!
                
                // self.storeMovies(json: movieData!)
                
                // Save the searched term
                self.saveSearchTerm(term)
                
            } else if movieData == nil {
                // jsonValue = self.retrieveStoredData() ?? [:]
            }
        }
        
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
