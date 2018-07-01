//
//  SearchViewController.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

/// Main search view controller of the application
class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Search results variables
    var movieSearchResults : MovieSearchResults? {
        didSet {
            if !movieSearchResults!.isEmpty {
                foundMovies.append(contentsOf: movieSearchResults!.results!)
            }
        }
    }
    var foundMovies = [Movie]() {
        didSet { self.searchTableView.reloadData() }
    }
    lazy var networkServices = NetworkServices()
    var searchTerms = [String]()
    var currentPage: Int = 1
    var maxPages: Int = 1
    var searchHistoryPreferredHeight: Int = 30
    var searchResultPreferredHeight: Int = 396
    var searchActive : Bool = false
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchTerms()
        searchTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Public methods
    
    /**
     Updates the searchTerms array from the Realm database using the database manager (DBManager)
     */
    func updateSearchTerms() {
        searchTerms.removeAll()
        let retrievedResults = DBManager.sharedInstance.retrieve()
        for i in 0..<retrievedResults.count {
            searchTerms.append(retrievedResults[i].name)
        }
    }
    
    /**
     Resets the table, varaibles and perform the search method given a search term.
     */
    func resetTableAndSearch(term: String?) {
        //Set all the variables back for the new search
        searchBar.resignFirstResponder()
        self.currentPage = 1
        foundMovies.removeAll()
        performSearch(for: term)
    }
}
