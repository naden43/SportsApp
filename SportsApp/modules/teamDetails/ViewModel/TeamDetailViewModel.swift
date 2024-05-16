//
//  TeamDetailViewModel.swift
//  SportsApp
//
//  Created by Salma on 14/05/2024.
//

import Foundation

class TeamDetailViewModel : TeamDetailsViewModelProtocol{
    
    let network : NetworkHandlerProtocol
    var bindTeamDetailsToList : ()->Void = {}
    var selectedTeam : TeamData?
    var selectedLeague : LeagueData?
    var endPointUrl : String?
    var teamsList : [Team]?
    var playersCount: Int?
    
    init(network: NetworkHandler , selectedTeam: TeamData , selectedLeague: LeagueData) {
        self.network = network
        self.selectedTeam = selectedTeam
        self.selectedLeague = selectedLeague
        
        if let leagueKey = selectedLeague.league_key, let teamKey = selectedTeam.away_team_key , let sportName = selectedLeague.sport_name {
            endPointUrl = "\(sportName)/?met=Teams&teamId=\(teamKey)"
        } else {
            endPointUrl = nil
        }
    }

    
    func implementBindTeamDetailsToList(bindTeamDetailsToList: @escaping () -> Void) {
        self.bindTeamDetailsToList = bindTeamDetailsToList
        

    }

    func loadTeamDetails() {
        network.loadData(url: endPointUrl ?? "football/?&met=Teams&teamId=152") { [weak self] (teamDetails: TeamDetails?, error) in
            guard let teamDetails = teamDetails else {
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Error: Failed to get team details")
                }
                return
            }
            
            self?.teamsList = teamDetails.result
            
            self?.bindTeamDetailsToList()
        }
    }

    func getTeamsListCount() -> Int {
        return teamsList?.count ?? 0
    }
    
    func getTeamDetailsAtIndex(index: Int) -> Team? {
        guard let teamsList = teamsList, index < teamsList.count else {
            
            return nil
        }
        
        let team = teamsList[index]
     
       if let teamName = team.team_name {
            print("Team Name: \(teamName)")
        }
        
        return team
    }

}



