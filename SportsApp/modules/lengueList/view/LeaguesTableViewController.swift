//
//  LenguesTableViewController.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    var homeViewModel : HomeViewModel?
    
    
    var leaguesViewModel : LeaguesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "LengueCell")
        
        
        leaguesViewModel = LeaguesViewModel(network: NetworkHandler.instance, selectedSport: homeViewModel?.getSelectedSport() ?? "football")
        
        let indecator = UIActivityIndicatorView(style: .large)
        indecator.center = view.center
        indecator.startAnimating()
        view.addSubview(indecator)
        
        leaguesViewModel?.implementBindLenguesToList {
            
            indecator.stopAnimating()
            self.tableView.reloadData()
        }
        
        leaguesViewModel?.loadLeagues()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel?.getLeaguesCount() ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.bounds.height/9
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LengueCell", for: indexPath) as! LeaguesTableViewCell
        
        
        let league = leaguesViewModel?.getLeagueAtIndex(index: indexPath.row)
        let url = URL(string: league?.league_logo ?? "")
        
        
        cell.lengueImage.kf.setImage(with: url , placeholder: UIImage(named: "leaguePlaceHolder"))
        cell.lengueName.text = league?.league_name ?? ""
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if leaguesViewModel?.checkReachability() == true {
            leaguesViewModel?.setSelectedLeague(index: indexPath.row)
            
            let leagueDetailsScreen = self.storyboard?.instantiateViewController(withIdentifier: "league_details_screen") as! LeaguesDetailsViewController
            
        
            leagueDetailsScreen.leagueListViewModel = leaguesViewModel
            
            self.present(leagueDetailsScreen, animated: true)
        }
        else{
            
            let alert = UIAlertController(title: nil, message: "Check your Internet Connection", preferredStyle: .actionSheet)
                   self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1){
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                }
                
            }
        }
        
        
    }
}
 
