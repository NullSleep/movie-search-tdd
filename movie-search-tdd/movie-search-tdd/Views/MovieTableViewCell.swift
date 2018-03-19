//
//  TableViewCell.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var movieImageView: RoundImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    // MARK: - Properties
    private lazy var networkServices = NetworkServices()
    
    // MARK: - Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    func configure(with movie: Movie) {
        self.movieNameLabel.text = movie.movieName
        self.releaseDateLabel.text = "Release date: " + (movie.releaseDate ?? "")
        self.movieOverview.text = movie.movieOverview
        
        if let imageURL = movie.moviePoster {
            let imagePath = networkServices.getImageUrl(path: imageURL, size: NetworkServicesRouter.posterSize.medium.rawValue)
            self.movieImageView.sd_setImage(with: imagePath, placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
