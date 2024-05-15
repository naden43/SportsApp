//
//  FavViewModel.swift
//  SportsApp
//
//  Created by Naden on 14/05/2024.
//

import Foundation
import Reachability

class FavViewModel : SharedLeagueDataViewModelProtocol{
   
    
    var favLeaguesDataSource : FavouriteSportsDataSource
    
    var favLeaguesList : [LeagueData]?
    
    var bindLeaguesToList : (() -> Void) = {}
    
    var selectedLeague: Int?
    
    let reachability = try! Reachability()

    
    
    init(favLeaguesDataSource: FavouriteSportsDataSource) {
        self.favLeaguesDataSource = favLeaguesDataSource
    }
    
    func getFavs() {
        
        favLeaguesDataSource.retriveFavLeagues { [weak self] leagues in
            
            self?.favLeaguesList = leagues
            self?.bindLeaguesToList()
        }
        
    }
    
    func getFavAtIndex(index : Int) -> LeagueData {
        
        return (favLeaguesList?[index])!
    }
    
    
    func getLeaguesCount()->Int{
        
        return favLeaguesList?.count ?? 0
    }
    
    
    func deleteLeagueAtIndex(index : Int){
        
        favLeaguesDataSource.deleteFavLeague(league: (favLeaguesList?[index])!)
        getFavs()
        
    }
    
    func setSelectedLeague(index: Int) {
        
        selectedLeague = index
    }
    
    func getSelectedLeague() -> LeagueData {
        
        return (favLeaguesList?[selectedLeague!])!
    }
    
    func checkReachability() -> Bool {
        
        switch reachability.connection {
            
            case .unavailable:
                return false
            case .wifi , .cellular:
                return true
    
        }
    }
    
    
}
