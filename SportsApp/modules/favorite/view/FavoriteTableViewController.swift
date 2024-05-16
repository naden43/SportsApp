//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit
import Kingfisher

class FavoriteTableViewController: UITableViewController {

    
    @IBOutlet weak var emptyIndecatorImage: UIImageView!
    var favViewModel : FavViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()


        let nibCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "LengueCell")

        favViewModel = FavViewModel(favLeaguesDataSource: FavouriteSportsDataSource.shared)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        favViewModel?.bindLeaguesToList = {
            
            if self.favViewModel?.getLeaguesCount() == 0 {
                
                self.emptyIndecatorImage.image = UIImage(named: "Sport family-pana")
            }
            else{
                
                self.emptyIndecatorImage.image = nil
            }
            
            self.tableView.reloadData()
        }
        favViewModel?.getFavs()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favViewModel?.getLeaguesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.bounds.height/8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LengueCell", for: indexPath) as! LeaguesTableViewCell

        let league = favViewModel?.getFavAtIndex(index: indexPath.row)
        let url = URL(string: league?.league_logo ?? league?.country_logo ?? "")
        cell.lengueImage.kf.setImage(with: url , placeholder: UIImage(named: "leaguePlaceHolder"))
        cell.lengueName.text = league?.league_name ?? "team \((league?.league_key)!)"
        

        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.contentView.layer.shadowRadius = 4
        cell.contentView.layer.masksToBounds = false
    

        return cell
    }
    
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Favourite League", message: "Are you sure you want to delete it ? ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive){_ in
                
                self.favViewModel?.deleteLeagueAtIndex(index: indexPath.row)
            })
            alert.addAction(UIAlertAction(title: "No", style: .default))
            
            present(alert, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if favViewModel?.checkReachability() == true {
            
            favViewModel?.setSelectedLeague(index: indexPath.row)
            
            let leagueDetailsScreen = self.storyboard?.instantiateViewController(withIdentifier: "league_details_screen") as! LeaguesDetailsViewController
            
        
            leagueDetailsScreen.leagueListViewModel = favViewModel
            
            self.present(leagueDetailsScreen, animated: true)
        }
        else {
            
            let alert = UIAlertController(title: nil, message: "Check your Internet Connection", preferredStyle: .actionSheet)
                   self.present(alert, animated: true, completion: nil)
                   
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1){
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                }

            }
                   
            
        }
        
        
        
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
