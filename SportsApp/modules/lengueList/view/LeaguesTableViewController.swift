//
//  LenguesTableViewController.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    
    var leaguesViewModel : LeaguesViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "LengueCell")
        
        
        leaguesViewModel = LeaguesViewModel(network: NetworkHandler.instance, selectedSport: "basketball")
        
        leaguesViewModel?.implementBindLenguesToList {
            
            self.tableView.reloadData()
        }
        
        
        leaguesViewModel?.loadLeagues()
      
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesViewModel?.getLeaguesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.bounds.height/8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LengueCell", for: indexPath) as! LeaguesTableViewCell
        
        
        let league = leaguesViewModel?.getLeagueAtIndex(index: indexPath.row)
        let url = URL(string: league?.league_logo ?? league?.country_logo ?? "")
        
        
        cell.lengueImage.kf.setImage(with: url)
        cell.lengueName.text = league?.league_name ?? ""
        
        cell.layer.cornerRadius = 100
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.contentView.layer.shadowRadius = 4
        cell.contentView.layer.masksToBounds = false
        
        
        
        return cell
    }
    
    
}
 
