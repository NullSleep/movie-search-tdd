//
//  RoundImageView.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/18/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
     // MARK: - Properties
    static let cornerRaiusFactor = 0.07
    
     // MARK: - Implementation for the rounded corners of the image
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width * CGFloat(RoundImageView.cornerRaiusFactor)
    }
}
