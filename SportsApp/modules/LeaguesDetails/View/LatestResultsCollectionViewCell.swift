//
//  LatestResultsCollectionViewCell.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.
//

 

import UIKit

class LatestResultsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstTeamPadge: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var secondTeamPadge: UIImageView!
    @IBOutlet weak var secondTeamName: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 20 
        self.contentView.layer.masksToBounds = true

    
        firstTeamPadge.layer.cornerRadius = firstTeamPadge.bounds.width / 2
        firstTeamPadge.layer.masksToBounds = true
        
        secondTeamPadge.layer.cornerRadius = secondTeamPadge.bounds.width / 2
        secondTeamPadge.layer.masksToBounds = true
        
        applyShadow(to: firstTeamPadge)
        applyShadow(to: secondTeamPadge)
    }
    
    private func applyShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 2
    }
}

