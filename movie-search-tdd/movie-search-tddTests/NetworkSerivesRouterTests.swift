//
//  NetworkSerivesRouter.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd

/// Network services router tests for the different services configuration
class NetworkSerivesRouter: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     tests the Router search configuration for a error when data is empty
     */
    func testCreateUrlForRequetsWithParameters() {
        let url = NetworkServicesRouter.searchMovies("batman", 1)
        XCTAssertNotNil(url, "URL couldn't be created.")
    }
    
    /**
     tests the Router search configuration for a error when search term is empty
     */
    func testCreateUrlForRequetsWithIncorrectTerm() {
        let url = NetworkServicesRouter.searchMovies("", 1)
        XCTAssertNotNil(url, "URL couldn't be created.")
    }
    
    /**
     tests the Router search configuration for a error when page is incorrect
     */
    func testCreateUrlForRequetsWithIncorrectPage() {
        let url = NetworkServicesRouter.searchMovies("batman", 0)
        XCTAssertNotNil(url, "URL Configuration couldn't be created.")
    }
    
    /**
     tests the Router image base url path configuration
     */
    func testGetBaseImageUrl() {
        let url = NetworkServicesRouter.imageBaseURLPath
        XCTAssertNotNil(url, "Image base path couldn't be obtained.")
    }
    
    /**
     tests the Router image size configuration
     */
    func testGetImageSize() {
        let size = NetworkServicesRouter.posterSize.small.rawValue
        XCTAssertNotNil(size, "Size couldn't be obtained.")
    }
}
