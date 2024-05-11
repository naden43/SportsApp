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
    
    let endPointUrl : String?

    var leaguesList : [LeagueData]?
    
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
}
