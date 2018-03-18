//
//  NetworkServicesTests.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/16/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd

/// Network services tests for the movie search API endpoints.
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
     This fucntion tests the API search endpoint for a success answer
     */
    func testGetSearchResultsForGivenMovie() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "NetworkServices Search API")
        
        // Make the network request to search for a term
        networkServices.searchTerm(for: "batman", page: 1) {
            movieData, error in
            
            // We make sure we that some data from the search was returned
            XCTAssertNotNil(movieData, "No search results recieved.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
         // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
         wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     tests the API search endpoint for a error when search term is empty
     */
    func testGetErrorSearchResultsForNoterm() {
        let expectation = XCTestExpectation(description: "NetworkServices Search API Error")

        networkServices.searchTerm(for: "", page: 1) {
            movieData, error in
            XCTAssertNotNil(error, "No error was recieved.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     tests the API search endpoint for a error when page is incorrect
     */
    func testGetErrorSearchResultsForIncorrectPage() {
        let expectation = XCTestExpectation(description: "NetworkServices Search API Error")
        
        networkServices.searchTerm(for: "Batman", page: 0) {
            movieData, error in
            XCTAssertNotNil(error, "No error was recieved.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     tests the API image endpoint for a success image url
     */
    func testGetImageForGivenConfiguration() {
        let imagePath = networkServices.getImageUrl(path: "http://image.tmdb.org/t/p", size: NetworkServicesRouter.posterSize.small.rawValue)
         XCTAssertNotNil(imagePath, "Image path couldn't be obtained.")
    }
    
}
