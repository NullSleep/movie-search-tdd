//
//  SearchViewController+UISearchBarDelegate.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/19/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import UIKit

/// UISearchBarDelegate extension for the SearchViewController
extension SearchViewController: UISearchBarDelegate {
    
    static let noDataFound = "No data was found"
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true;
        self.searchTableView.reloadData()
        
        self.searchTableView.setNeedsLayout()
        self.searchTableView.layoutIfNeeded()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
        self.searchTableView.reloadData()
        resetTableAndSearch(term: searchBar.text)
    }
    
    // MARK: - Private methods
    
    /*
     Mehtod to perfrom call search service given a seach term
     */
    func performSearch(for term: String?) {
        guard let term = term else { return }
        
        activityIndicator.startAnimating()
        
        //Calling the network services to perform the search
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
                Alert.showAlert(title: "Error", message: SearchViewController.noDataFound, vc: self)
            } else if error != nil {
                Alert.showAlert(title: "Error", message: (error?.localizedDescription)! , vc: self)
            }
        }
    }
    
    /*
     Mehtod to perfrom call save the succesful search term
     */
    func saveSearchTerm(_ term: String) {
        if self.searchTerms.contains(term) {
            return
        }
        
        let searchTerm = SearchTerm()
        searchTerm.name = term
        DBManager.sharedInstance.save(object: searchTerm)
        searchTerms.insert(term, at: 0)
    }
}
