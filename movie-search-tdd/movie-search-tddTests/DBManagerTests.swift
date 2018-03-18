//
//  DBManagerTests.swift
//  movie-search-tddTests
//
//  Created by Carlos Arenas on 3/18/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search_tdd

class DBManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRetrieveDataFromRealm() {
        let retrievedResults = DBManager.sharedInstance.retrieve()
         XCTAssertNotNil(retrievedResults, "No data was found.")
    }
    
    func testSaveDataInRealm() {
        let searchTerm = SearchTerm()
        searchTerm.name = "batman"
        let result = DBManager.sharedInstance.save(object: searchTerm)
        XCTAssertNotNil(result, "The data couldn't be saved.")
    }
}
