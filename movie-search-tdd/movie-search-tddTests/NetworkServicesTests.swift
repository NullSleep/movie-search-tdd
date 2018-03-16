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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     This fucntion tests the API search endpoint
     */
    func getSuccessfullSearchResultsForRandomMovieTest() {
        let api = apiHandler()
        let result = api.searchTerm(term: "Batman", page:"1")
        XCTAssertEqual(result, true)
    }
    
}
