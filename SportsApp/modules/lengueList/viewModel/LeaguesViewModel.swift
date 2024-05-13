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
    }

    
    func implementBindLenguesToList(bindLenguesToList: @escaping () -> Void) {
        self.bindLenguesToList = bindLenguesToList
    }

    func loadLeagues() {
        
        network.loadData(onCompletion: { [weak self] (lenguesList:League) in
            
            self?.leaguesList = lenguesList.result
            
            //DispatchQueue.main.sync {
                
                self?.bindLenguesToList()
                
            //}
        
            
        }, url: endPointUrl ?? "football/?met=Leagues")
        
        
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
