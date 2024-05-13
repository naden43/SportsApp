//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.
//

import UIKit

class LeaguesDetailsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var leagueDetailsViewModel : LeaguesDetailsViewModelProtocol?
    
    var leagueListViewModel : LeaguesViewModel?
    
    
    @IBOutlet weak var leaguesDetailsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        leaguesDetailsCollectionView.dataSource = self
        leaguesDetailsCollectionView.delegate = self
        
        // Register header view
        leaguesDetailsCollectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeaderView.reuseIdentifier)
        
        
        leagueDetailsViewModel = LeaguesDetailsViewModel(network: NetworkHandler.instance, mySelectedSport: (leagueListViewModel?.getSelctedSport())! ,myleagueId:(leagueListViewModel?.getLeagueKey())!)
        
        leagueDetailsViewModel?.implementBindLeagueDetailsToList(bindLeagueDetailsToList: ) {
        
            self.leaguesDetailsCollectionView.reloadData()
        }

        
        leagueDetailsViewModel?.loadUpcomingEvents()
        leagueDetailsViewModel?.loadLatestResults()
        
        
        let layout = UICollectionViewCompositionalLayout { index, environment in
            switch index {
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawCenterSection()
            case 2:
                return self.drawBottomSection()
            default:
                return self.drawTopSection()
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
        switch section{
        case 0:
            return (leagueDetailsViewModel?.getUpcomingEventsCount())!
        case 1:
            return (leagueDetailsViewModel?.getLatestResultsCount())!
            
        case 2:
            return 5
        default:
            break

        }
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            
            
            let upcomingEvent = leagueDetailsViewModel?.getUpcomingEventAtIndex(index: indexPath.row)
            if let homeTeamLogoString = upcomingEvent?.home_team_logo, let homeTeamLogoURL = URL(string: homeTeamLogoString) {
                cell.firstTeamImageView.kf.setImage(with: homeTeamLogoURL)
            }
            
            if let awayTeamLogoString = upcomingEvent?.away_team_logo, let awayTeamLogoURL = URL(string: awayTeamLogoString) {
                cell.secondTeamImageView.kf.setImage(with: awayTeamLogoURL)
            }
            
            cell.eventName.text = upcomingEvent?.league_name
            cell.firstTeamName.text = upcomingEvent?.event_home_team
            cell.secondTeamName.text = upcomingEvent?.event_away_team
            
            return cell
        case 1:
            print("enter")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as! LatestResultsCollectionViewCell
            
            let latestResult = leagueDetailsViewModel?.getLatestResultsAtIndex(index: indexPath.row)
            if let homeTeamLogoString = latestResult?.home_team_logo, let homeTeamLogoURL = URL(string: homeTeamLogoString) {
                cell.firstTeamPadge.kf.setImage(with: homeTeamLogoURL)
            }
            
            if let awayTeamLogoString = latestResult?.away_team_logo, let awayTeamLogoURL = URL(string: awayTeamLogoString) {
                cell.secondTeamPadge.kf.setImage(with: awayTeamLogoURL)
            }
            
            cell.firstTeamName.text = latestResult?.event_home_team
            cell.secondTeamName.text = latestResult?.event_away_team
            
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
         let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
         
         let section = NSCollectionLayoutSection(group: group)
        
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
  
