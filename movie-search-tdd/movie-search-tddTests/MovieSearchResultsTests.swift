//
//  MovieSearchResultsTests.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd
import SwiftyJSON

/// Movie search results tests for mapping the movie search results.
class MovieSearchResultsTests: XCTestCase {
    
    /// Data structure to handle the movie search results
    let movieSearchResults: MovieSearchResults? = nil
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     This fucntion tests for the existence of the local JSON file
     */
    func testGetLocalJsonResponse() {
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: "Resources/search-respo", ofType: "json") {
             XCTAssertNotNil(jsonFilePath, "No file was found.")
        }
    }
    
    /**
     Test the movie search results mapping
     */
    func testMovieSearchResultObjectMapping() {
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: "Resources/search-respo", ofType: "json") {
            let jsonString = try? String(contentsOfFile: jsonFilePath, encoding: String.Encoding.utf8)
            let json = JSON(parseJSON: jsonString!)
            if let movieSearchResults = self.movieSearchResults?.movieSearchResultsFromReponse(searchResults: json) {
                XCTAssertNotNil(movieSearchResults, "No data was mapped.")
            }
        }
    }
    
}
