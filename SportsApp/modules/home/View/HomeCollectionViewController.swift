//
//  HomeCollectionViewController.swift
//  SportsApp
//
//  Created by Salma on 10/05/2024.
//

//import UIKit



import UIKit


class HomeCollectionViewController: UICollectionViewController {
    
    var homeViewModel : HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        // Set up the FlowLayout
        let flowLayout = FlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        print("in view did load")
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.getSportsCount() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCollectionViewCell", for: indexPath) as! SportCollectionViewCustomCell
        
        
        let sport = homeViewModel?.getSportAtIndex(index: indexPath.row)
        cell.sportNameLabel.text = sport?.name
        cell.sportImageView.image = UIImage(named: sport!.imageName)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeViewModel?.setSelectedSport(index: indexPath.row)
        print("setSelectedSport \(homeViewModel?.getSelectedSport())")
        
        let allLeaguesVc = self.storyboard?.instantiateViewController(identifier: "leaguesListScreen") as! LeaguesTableViewController
        
        allLeaguesVc.homeViewModel = self.homeViewModel
        
        self.navigationController?.pushViewController(allLeaguesVc, animated: true)
        
    }
    



}


