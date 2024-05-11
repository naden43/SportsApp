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
        
        leaguesViewModel = LeaguesViewModel(network: NetworkHandler.instance, selectedSport: "football")
        
        leaguesViewModel?.implementBindLenguesToList {
            
            self.tableView.reloadData()
        }
        

        leaguesViewModel?.loadLeagues()
        /*let network = NetworkHandler.instance
        network.loadData(onCompletion: { (lengues:Lengue) in
            print(lengues.result?[0].league_name ?? "")
        }, url: "football/?met=Leagues")*/
        
        
        
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
        
        
        cell.lengueImage.kf.setImage(with: url , placeholder: UIImage(named: "football-player"))
        cell.lengueName.text = league?.league_name ?? ""

        cell.layer.cornerRadius = 100
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.contentView.layer.shadowRadius = 4
        cell.contentView.layer.masksToBounds = false
    
        

        return cell
    }
    
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}
