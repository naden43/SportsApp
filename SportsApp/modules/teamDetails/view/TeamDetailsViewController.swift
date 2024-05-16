//
//  test.swift
//  SportsApp
//
//  Created by Salma on 14/05/2024.
//

//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {

    @IBOutlet weak var playerCollectionView: UICollectionView!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    var leaguesDetailsViewModel: LeaguesDetailsViewModelProtocol?
    var teamDetailsViewModel: TeamDetailsViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerCollectionView.dataSource = self
        playerCollectionView.delegate = self
        
        teamDetailsViewModel = TeamDetailViewModel(network: NetworkHandler.instance, selectedTeam: (leaguesDetailsViewModel?.getSelectedTeam())!, selectedLeague: (leaguesDetailsViewModel?.getSelectedLeague())!)
        
        
        teamDetailsViewModel?.implementBindTeamDetailsToList {
            self.playerCollectionView.reloadData()

        }
            
        teamDetailsViewModel?.loadTeamDetails()
        
        let layout = UICollectionViewCompositionalLayout{
            (section , enviroment) in
            
            let section = self.drawSection()
    
            return section
        }
        playerCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func drawSection()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.3))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
        

        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 10
        return teamDetailsViewModel?.getTeamDetailsAtIndex(index: section)?.players?.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        
        if let team = teamDetailsViewModel?.getTeamDetailsAtIndex(index: indexPath.section) {
            if let teamLogoString = team.team_logo, let teamLogoURL = URL(string: teamLogoString) {
                self.teamImage.kf.setImage(with: teamLogoURL)
            } else {
                self.teamImage.image = UIImage(named: "placeholder_image")
            }
            
            if let teamName = team.team_name {
                self.teamName.text = teamName
            } else {
                self.teamName.text = "Unknown Team"
            }
            
            if let players = team.players {
                let player = players[indexPath.item]
                
                if let playerImageString = player.player_image, let playerImageURL = URL(string: playerImageString) {
                    cell.personImage.kf.setImage(with: playerImageURL)
                } else {
                    cell.personImage.image = UIImage(named: "placeholder_image")
                }
                
                cell.personName.text = player.player_name
            } else {
                cell.personName.text = "Unknown"
                cell.personImage.image = UIImage(named: "placeholder_image")
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

}

