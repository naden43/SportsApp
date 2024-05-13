//
//  FlowLayout.swift
//  SportsApp
//
//  Created by Salma on 10/05/2024.
//
import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let collectionViewWidth = collectionView?.frame.width ?? 0
        let cellWidth = (collectionViewWidth - 30) / 2 // Adjust 50 according to your requirements
        
        itemSize = CGSize(width: cellWidth, height: UIScreen.main.bounds.height * 0.35)
        
        minimumLineSpacing = 10 // Horizontal spacing between items
        
        sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10) // Space from top, left, bottom, and right
    }
}

