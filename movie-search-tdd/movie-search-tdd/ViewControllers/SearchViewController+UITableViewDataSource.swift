//
//  SearchViewController+UITableViewDataSource.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/19/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import UIKit

/// UITableViewDataSource extension for the SearchViewController
extension SearchViewController: UITableViewDataSource {
    
    static let searchTermsCellID = "Cell"
    static let movieCellID = "MovieCell"
    
    //MARK: - UITableViewDataSource
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
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.searchTermsCellID, for: indexPath)
            cell.textLabel!.text = searchTerms[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.movieCellID, for: indexPath) as! MovieTableViewCell
        let movie = self.foundMovies[indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
    }
}

