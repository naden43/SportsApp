//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.
//

import UIKit

class LeaguesDetailsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var leaguesDetailsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesDetailsCollectionView.dataSource = self
        leaguesDetailsCollectionView.delegate = self
        
        // Register header view
        leaguesDetailsCollectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeaderView.reuseIdentifier)
        
        let layout = UICollectionViewCompositionalLayout { index, environment in
            switch index {
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawCenterSection()
            case 2:
                return self.drawBottomSection()
            default:
                return self.drawTopSection() // Default to top section if section index is out of range
            }
        }
        
        leaguesDetailsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyHeaderView.reuseIdentifier, for: indexPath) as! MyHeaderView
        
        switch indexPath.section {
        case 0:
            headerView.setTitle("Upcoming Events:")
        case 1:
            headerView.setTitle("Latest Results:")
        case 2:
            headerView.setTitle("Teams:")
        default:
            break
        }
        
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            // Configure the cell for the first section (Upcoming Events)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as! LatestResultsCollectionViewCell
            // Configure the cell for the second section (Latest Results)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! LeagueTeamCollectionViewCell
            // Configure the cell for the third section (Team Detail)
            return cell
        default:
            fatalError("Unexpected section index")
        }
    }
    
    
    
    
    
    @IBAction func btnFav(_ sender: Any) {
    }
    
    
    
    
    func drawTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
    
    
    func drawCenterSection() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(100))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(100))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16)
         section.boundarySupplementaryItems = [
             NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
         ]
         return section
     }


    
    func drawBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
    
    
}
  
