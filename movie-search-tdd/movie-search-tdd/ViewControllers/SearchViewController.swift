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
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var networkServices = NetworkServices()
    
    private var searchTerms = [String]()
    
    // Search results variables
    private var searchResults: NSDictionary = NSDictionary()
    
    private var movieSearchResults : MovieSearchResults? {
        didSet { self.searchTableView.reloadData() }
    }
    
    
    private var foundMovies = [MovieObj]() {
        didSet { self.searchTableView.reloadData() }
    }
    private var retrievedMovies = [MovieObj]() {
        didSet {
            if !retrievedMovies.isEmpty {
                foundMovies = retrievedMovies
            }
        }
    }
    
    private var currentPage: Int = 1
    private var searchActive : Bool = false
    
    private var resultadoBusqueda : MovieSearchResults?
    
    //MARK: - View Lifecycle

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
        
        networkServices.BASICSearch(for: term, page: self.currentPage) {
            movieData, error in
            
            self.activityIndicator.stopAnimating()
            
            self.retrievedMovies.removeAll()
            
            var jsonValue: JSON = [:] {
                didSet {
                    self.createMovies(json: jsonValue, page: self.currentPage)
                }
            }
            
            if movieData != nil {
                self.searchActive = false;
                
                jsonValue = movieData!
                
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
    
    func createMovies(json: JSON, page: Int) {
        
        let moviesFound = json["results"].arrayValue
        let pageRetrieved = json["page"].int
        
        if pageRetrieved == page {
            self.currentPage = page
            
            for item in moviesFound {
                let movie = MovieObj()
                print(item["title"].string ?? "")
                movie.moviePoster = item["poster_path"].string
                movie.movieName = item["title"].string
                movie.releaseDate = item["release_date"].string
                movie.movieOverview = item["overview"].string
                self.retrievedMovies.append(movie)
            }
        }
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
            return 30.0
        }
        return 350.0
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
