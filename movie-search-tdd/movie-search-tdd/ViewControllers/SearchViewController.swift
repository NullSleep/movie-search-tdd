//
//  SearchViewController.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Search results variables
    private var movieSearchResults : MovieSearchResults? {
        didSet {
            if !movieSearchResults!.isEmpty {
                foundMovies = movieSearchResults!.results!
            }
        }
    }
    private var foundMovies = [Movie]() {
        didSet { self.searchTableView.reloadData() }
    }
    private lazy var networkServices = NetworkServices()
    private var searchTerms = [String]()
    private var currentPage: Int = 1
    private var searchHistoryPreferredHeight: Int = 30
    private var searchResultPreferredHeight: Int = 350
    private var searchActive : Bool = false
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true;
        self.searchTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchActive = false;
        self.searchTableView.reloadData()
        performSearch(for: searchBar.text)
    }
    
    func saveSearchTerm(_ term: String) {
        if self.searchTerms.contains(term) {
            return
        }
        searchTerms.insert(term, at: 0)
    }
    
    func performSearch(for term: String?) {
        guard let term = term else { return }
        
        activityIndicator.startAnimating()
        
        networkServices.searchTerm(for: term, page: self.currentPage) {
            movieData, error in
            
            self.activityIndicator.stopAnimating()
            
            if movieData != nil {
                self.searchActive = false;
                
                // Assign the search results
                self.movieSearchResults = movieData
                
                // Save the searched term
                self.saveSearchTerm(term)
                
            } else if movieData == nil {
                // jsonValue = self.retrieveStoredData() ?? [:]
            }
        }
    }
    
    func shwoNoSearchAlert(for term: String) {
        let alertController = UIAlertController(title: "Error", message: "No movies could be found for \(term). Try searching for something else)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchActive {
            return searchTerms.count
        }
        return foundMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.searchActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel!.text = searchTerms[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = self.foundMovies[indexPath.row]
        cell.movieNameLabel.text = movie.movieName
        cell.releaseDateLabel.text = movie.releaseDate
        cell.movieOverview.text = movie.movieOverview
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.searchActive {
            return CGFloat(searchHistoryPreferredHeight)
        }
        return CGFloat(searchResultPreferredHeight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.foundMovies.count-1 {
            self.currentPage += 1
            performSearch(for: searchBar.text)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.searchActive {
            let searchTermSelected = searchTerms[indexPath.row]
            self.searchBar.text = searchTermSelected
            searchBar.resignFirstResponder()
            performSearch(for: searchTermSelected)
        }
    }
}
