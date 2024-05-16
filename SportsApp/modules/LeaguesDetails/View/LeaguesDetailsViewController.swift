//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 11/05/2024.
//

import UIKit

class LeaguesDetailsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var leagueDetailsViewModel : LeaguesDetailsViewModelProtocol?
    var favViewModel :FavViewModel?
    
    
    @IBOutlet weak var emptyIndecatorImage: UIImageView!
    
    @IBOutlet weak var favImage: UIButton!
    var leagueListViewModel : SharedLeagueDataViewModelProtocol?
    
    
    @IBOutlet weak var leaguesDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        leaguesDetailsCollectionView.dataSource = self
        leaguesDetailsCollectionView.delegate = self
        
        
        leaguesDetailsCollectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeaderView.reuseIdentifier)
        
        
        leagueDetailsViewModel = LeaguesDetailsViewModel(network: NetworkHandler.instance, selectedLeague: (leagueListViewModel?.getSelectedLeague())!, favLeagueDataSource: FavouriteSportsDataSource.shared, favDataSource: FavouriteSportsDataSource.shared)
        favViewModel = FavViewModel(favLeaguesDataSource: FavouriteSportsDataSource.shared)
        
        setFav()
        
        let indecator = UIActivityIndicatorView(style: .large)
        indecator.center = view.center
        indecator.startAnimating()
        view.addSubview(indecator)
        
        leagueDetailsViewModel?.implementBindLeagueDetailsToList(bindLeagueDetailsToList: ) {
            
            indecator.stopAnimating()
            print(self.leagueDetailsViewModel?.getSectionCount())
            if self.leagueDetailsViewModel?.getSectionCount() == 0{
                
                self.emptyIndecatorImage.image = UIImage(named: "empty-box")
                
            }
            else{
                self.emptyIndecatorImage.image = nil
                self.leaguesDetailsCollectionView.reloadData()
            }
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
    
    func setFav() {
        
        let result = (leagueDetailsViewModel?.checkFavState())!
        
        if  result  == false {
            
            print("enter here ")
            favImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            print("enter here ")
            
            favImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyHeaderView.reuseIdentifier, for: indexPath) as! MyHeaderView
        
        
        if leagueDetailsViewModel?.getSectionCount() != 0 {
            print("hereeeeeeeeeeeeeeeee hi")
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
            
        }
        return headerView
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return leagueDetailsViewModel?.getSectionCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return (leagueDetailsViewModel?.getUpcomingEventsCount())!
        case 1:
             return (leagueDetailsViewModel?.getLatestResultsCount())!
            
            
        case 2:
            return (leagueDetailsViewModel?.getTeamsListCount())!
        default:
            break
            
        }
        
        return 0
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
            cell.eventDate.text = upcomingEvent?.event_date
            cell.eventTime.text = upcomingEvent?.event_time
            
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
            
            if latestResult?.event_home_team == "" {
                latestResult?.event_home_team = "Team 1"
            }
            
            if latestResult?.event_away_team == "" {
                latestResult?.event_away_team = "Team 2"
            }
            
            cell.firstTeamName.text = latestResult?.event_home_team
            cell.secondTeamName.text = latestResult?.event_away_team
            cell.scoreLabel.text = latestResult?.event_final_result
            
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! LeagueTeamCollectionViewCell
            
            let teamInfo = leagueDetailsViewModel?.getTeamsOfLeagueAtIndex(index: indexPath.row)
            
            if let homeTeamLogoString = teamInfo?.home_team_logo, let homeTeamLogoURL = URL(string: homeTeamLogoString) {
                cell.teamImageView.kf.setImage(with: homeTeamLogoURL)
            }

            
            return cell
        default:
            fatalError("Unexpected section index")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2{
            if leagueDetailsViewModel?.checkReachability() == false {
                
                let alert = UIAlertController(title: nil, message: "Check your Internet Connection", preferredStyle: .actionSheet)
                self.present(alert, animated: true, completion: nil)
                
                
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1){
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }else{
                leagueDetailsViewModel?.setSelectedTeam(index: indexPath.row)
                
                
                let teamDetailsScreen = self.storyboard?.instantiateViewController(withIdentifier: "team_details") as! TeamDetailsViewController
                
                teamDetailsScreen.leaguesDetailsViewModel = leagueDetailsViewModel
                
                self.present(teamDetailsScreen, animated: true)
            }
        
        }
    }
    
    
    @IBAction func btnFav(_ sender: Any) {
        if leagueDetailsViewModel?.checkFavState() ?? false {
            
            
            let alert = UIAlertController(title: "Favourite League", message: "Are you sure you want to delete it ? ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive){_ in
                
                self.leagueDetailsViewModel?.deleteLeagueFromFav()
                self.favImage.setImage(UIImage(systemName: "heart"), for: .normal)
                
            })
            alert.addAction(UIAlertAction(title: "No", style: .default))
            
            present(alert, animated: true)
            
           
            
        } else {
            
            leagueDetailsViewModel?.addLeagueToFav()
            
            favImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            showSavedFavoriteItem()
        }
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
        
        // animation
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        let minScale: CGFloat = 0.8
        let maxScale: CGFloat = 1.0
        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        }
        return section
    }
    
    
    func drawCenterSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.13))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
    
    
    
    func drawBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        // animation
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        let minScale: CGFloat = 0.8
        let maxScale: CGFloat = 1.0
        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        }

        return section
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func showSavedFavoriteItem() {
        let alert = UIAlertController(title: "League saved as favorite!", message: nil, preferredStyle: .actionSheet)
        
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1){
            DispatchQueue.main.async {
                alert.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    func checkInternetConnection(){
        
   
        

    }
    
    
}



