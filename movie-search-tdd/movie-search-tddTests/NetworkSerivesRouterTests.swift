//
//  NetworkSerivesRouter.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd

class NetworkSerivesRouter: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     tests the API search endpoint for a error when data is empty
     */
    func testCreateUrlForRequetsWithParameters() {
        let url = NetworkServicesRouter.serachMovies("batman", 1)
        XCTAssertNotNil(url, "Url couldn't be created.")
    }
    
    /**
     tests the API search endpoint for a error when search term is empty
     */
    func testCreateUrlForRequetsWithIncorrectTerm() {
        let url = NetworkServicesRouter.serachMovies("", 1)
        XCTAssertNotNil(url, "Url couldn't be created.")
    }
    
    /**
     tests the API search endpoint for a error when page is incorrect
     */
    func testCreateUrlForRequetsWithIncorrectPage() {
        let url = NetworkServicesRouter.serachMovies("", 0)
        XCTAssertNotNil(url, "Url couldn't be created.")
    }
}
