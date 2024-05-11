//
//  SportCollectionViewCell.swift
//  SportsApp
//
//  Created by Salma on 10/05/2024.
import UIKit

class SportCollectionViewCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var sportImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Make image view's corners rounded
        sportImageView.layer.cornerRadius = 10 // Adjust the radius as needed
        sportImageView.layer.masksToBounds = true // Ensure that the image is clipped to the rounded corners
        
        contentView.layer.cornerRadius = 20 // Adjust the radius as needed
        contentView.layer.masksToBounds = true
    }
}
