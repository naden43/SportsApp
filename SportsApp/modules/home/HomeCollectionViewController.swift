//
//  HomeCollectionViewController.swift
//  SportsApp
//
//  Created by Salma on 10/05/2024.
//

//import UIKit



import UIKit

struct Sport {
    let name: String
    let imageName: String
}

class HomeCollectionViewController: UICollectionViewController {
    
    // Dummy data array
    let sports: [Sport] = [
        Sport(name: "Football", imageName: "football"),
        Sport(name: "Basketball", imageName: "basketBall"),
        Sport(name: "Tennis", imageName: "tennis"),
        Sport(name: "Cricket", imageName: "cricket")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the FlowLayout
        let flowLayout = FlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        print("in view did load")
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

   /* override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCollectionViewCell", for: indexPath) as! SportCollectionViewCustomCell
        
     
        let sport = sports[indexPath.item]
        cell.sportNameLabel.text = sport.name
        cell.sportImageView.image = UIImage(named: sport.imageName)
        
        return cell
    }
    */



}


