//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Naden on 12/05/2024.
//

import Foundation

class LeaguesViewModel : LeaguesViewModelProtocol {
   

    let network : NetworkHandlerProtocol
     
    var bindLenguesToList : ()->Void = {}
    
    var selectedSport : String
    
    var selectedLeague : Int?
    
    let endPointUrl : String?

    var leaguesList : [LeagueData]?
    
    var leagueID : Int?
    
    init(network: NetworkHandler , selectedSport:String) {
        self.network = network
        self.selectedSport = selectedSport
        endPointUrl = "\(selectedSport)/?met=Leagues"
        print("all endPoint url \(endPointUrl)")
    }

    
    func implementBindLenguesToList(bindLenguesToList: @escaping () -> Void) {
        self.bindLenguesToList = bindLenguesToList
    }

    func loadLeagues() {
        
            network.loadData(url: endPointUrl ?? "football/?met=Leagues") { [weak self] (leagues:League? , error)in
                
                guard let leagues = leagues else {
                    
                    guard let error = error else {return}
                    
                    print(error.localizedDescription)
                    
                    return
                    
                }
                
                self?.leaguesList = leagues.result
                               
                self?.bindLenguesToList()
                
                
            }
            
            
        }
    
    func getLeaguesCount() -> Int {
        
        return leaguesList?.count ?? 0
    }
    
    func getLeagueAtIndex(index:Int) -> LeagueData?{
        
        return leaguesList?[index]
    }
        
    func setSelectedSport(sport:String){
        
        selectedSport = sport
    }
    
    func getSelctedSport() -> String {
        
        return selectedSport
    }
    
    func setSelectedLeague(index:Int){
        selectedLeague = index
    }
    func getSelectedLeague()-> LeagueData{
        
      leaguesList?[selectedLeague!].sport_name = selectedSport
        return (leaguesList?[selectedLeague!])!
    }
}
