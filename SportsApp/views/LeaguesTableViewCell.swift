//
//  LenguesTableViewCell.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var lengueName: UILabel!
    
    @IBOutlet weak var lengueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lengueImage.layer.cornerRadius = lengueImage.frame.width/2
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
