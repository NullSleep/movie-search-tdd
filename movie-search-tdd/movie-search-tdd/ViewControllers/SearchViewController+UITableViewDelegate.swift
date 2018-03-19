//
//  SearchViewController+UITableViewDelegate.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/19/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import UIKit

/// UITableViewDelegate extension for the SearchViewController
extension SearchViewController: UITableViewDelegate {
    
    //MARK: - UITableViewDelegate
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
            //Get the term to search and search it
            let searchTermSelected = searchTerms[indexPath.row]
            self.searchBar.text = searchTermSelected
            resetTableAndSearch(term: searchTermSelected)
        }
    }
}
