//
//  LeagueTeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.
//

import UIKit

class LeagueTeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        teamImageView.layer.cornerRadius = teamImageView.bounds.width / 2
        teamImageView.layer.masksToBounds = true
    }
}


