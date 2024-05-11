//
//  PlayerCollectionViewCell.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var personName: UILabel!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            personImage.layer.cornerRadius = personImage.frame.width / 2
            personImage.clipsToBounds = true
        }
}
