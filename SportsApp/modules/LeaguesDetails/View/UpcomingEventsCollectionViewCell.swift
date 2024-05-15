//
//  UpcomingEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.


import UIKit

class UpcomingEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var secondTeamName: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 20 // Adjust the corner radius as needed
        self.layer.masksToBounds = false // Allow shadow to appear outside the cell bounds
        self.contentView.layer.cornerRadius = 10 // Adjust the corner radius as needed
        self.contentView.layer.masksToBounds = true
        
        // Adjust the size of image views
        let imageSize = CGSize(width: 30, height: 300) // Set your desired size here
        firstTeamImageView.frame.size = imageSize
        secondTeamImageView.frame.size = imageSize
        
        // Make the background of image views circular
        firstTeamImageView.layer.cornerRadius = imageSize.width / 2
        firstTeamImageView.layer.masksToBounds = true
        
        secondTeamImageView.layer.cornerRadius = imageSize.width / 2
        secondTeamImageView.layer.masksToBounds = true
        
        applyShadow(to: firstTeamImageView)
        applyShadow(to: secondTeamImageView)
    }
    
    private func applyShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 2
    }
}








