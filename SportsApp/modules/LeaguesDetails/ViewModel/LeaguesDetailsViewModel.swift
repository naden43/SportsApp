//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Salma on 12/05/2024.
//


import Foundation

class LeaguesDetailsViewModel: LeaguesDetailsViewModelProtocol {
    
    let network: NetworkHandlerProtocol
    var  favLeagueDataSource : FavouriteSportsDataSource
    var bindLeagueDetailsToList: () -> Void = {}
    var upcomingEventsEndPoint: String?
    var latestResultsEndPoint: String?
    var upcomingEventList: [EventData]?
    var latestResultsList: [EventData]?
    var teamResultList : [TeamData]?
    var startDate: String?
    var stopDate: String?
    var selectedLeague : LeagueData?
    var selectedTeam : TeamData?
    
    
  
    init(network: NetworkHandler, selectedLeague : LeagueData, favLeagueDataSource : FavouriteSportsDataSource) {
        self.network = network
        self.favLeagueDataSource = favLeagueDataSource
        self.selectedLeague = selectedLeague
        getEndPointOfUpcomingEvents(selectedSport: selectedLeague.sport_name!, leagueId: String(selectedLeague.league_key!))
        print("upcomingEventsEndPoint \(upcomingEventsEndPoint)")
        getEndPointOfLatestResults(selectedSport: selectedLeague.sport_name!, leagueId: String(selectedLeague.league_key!))
        
        print("latest \(latestResultsEndPoint)")

    }

    func getEndPointOfUpcomingEvents(selectedSport: String, leagueId: String) {
        let dates = calculateDatesForUpcomingEvents()
        startDate = dates.startDate
        stopDate = dates.stopDate
        upcomingEventsEndPoint = "\(selectedSport)?met=Fixtures&leagueId=\(leagueId)&from=\( startDate!)&to=\(stopDate!)"
    }

    func getEndPointOfLatestResults(selectedSport: String, leagueId: String) {
        let dates = calculateDatesForLatestResults()
        startDate = dates.startDate
        stopDate = dates.stopDate
        latestResultsEndPoint = "\(selectedSport)?met=Fixtures&leagueId=\(leagueId)&from=\(startDate!)&to=\(stopDate!)"
    }

    func implementBindLeagueDetailsToList(bindLeagueDetailsToList: @escaping () -> Void) {
        self.bindLeagueDetailsToList = bindLeagueDetailsToList
    }

    func getUpcomingEventsCount() -> Int {
        return upcomingEventList?.count ?? 0
    }

    func getLatestResultsCount() -> Int {
        return latestResultsList?.count ?? 0
    }
    
    func getTeamsListCount() -> Int {
        return teamResultList?.count ?? 0
    }

    func getUpcomingEventAtIndex(index: Int) -> EventData? {
        return upcomingEventList?[index]
    }

    func getLatestResultsAtIndex(index: Int) -> EventData? {
        return latestResultsList?[index]
    }
    
    func getTeamsOfLeagueAtIndex(index: Int) -> TeamData? {
        return teamResultList?[index]
    }
    
    func setSelectedTeam(index : Int){
        selectedTeam = teamResultList![index]
        
    }
    
    func getSelectedTeam()->TeamData{
        return selectedTeam!
    }

    
    func getSelectedLeague()->LeagueData{
        return selectedLeague!
    }
     
    func loadUpcomingEvents() {
        network.loadData(url: upcomingEventsEndPoint ?? "football?met=Fixtures&leagueId=205&from=2023-05-18&to=2024-05-18") {[weak self] (upcomingEventList:Event? , error) in
            
            
            guard let upcomingEventList = upcomingEventList else {
                
                guard let error = error else{return}
                print(error.localizedDescription)
                return
            }
            self?.upcomingEventList = upcomingEventList.result
            
            self?.bindLeagueDetailsToList()
        }
    }
            
         
         
         
   func loadLatestResults() {
                      
             network.loadData(url: latestResultsEndPoint ??  "football?met=Fixtures&leagueId=205&from=2023-05-18&to=2024-05-18") {[weak self] (latestResultsList: Event? , error) in
                 
                 guard let latestResultsList = latestResultsList else {
                     
                     guard let error = error else{return}
                     print(error.localizedDescription)
                     return
                 }
                 
                    self?.latestResultsList = latestResultsList.result
                    self?.getTeamInfo() // Call getTeamInfo after updating latestResultsList

                    self?.bindLeagueDetailsToList()
                }
         }

    func calculateDatesForUpcomingEvents() -> (startDate: String, stopDate: String) {
        let currentDate = Date()
        let calendar = Calendar.current
        let stopDate = calendar.date(byAdding: .day, value: 7, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: currentDate)
        let stopDateString = dateFormatter.string(from: stopDate)
        print("start date \(startDateString) and end date \(stopDateString)")
        return (startDateString, stopDateString)
    }

    func calculateDatesForLatestResults() -> (startDate: String, stopDate: String) {
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .year, value: -1, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: startDate)
        let stopDateString = dateFormatter.string(from: currentDate)
        return (startDateString, stopDateString)
    }
    
    func addLeagueToFav(){
        
        favLeagueDataSource.addFavLeague(league: selectedLeague!)
        
    }
    
    func getTeamInfo(){
        if let latestResultsList = latestResultsList {
            var teams = [TeamData]()
            for eventData in latestResultsList {
                let teamInfo = TeamData(home_team_logo: eventData.home_team_logo,
                                        away_team_logo: eventData.away_team_logo,
                                        event_home_team: eventData.event_home_team,
                                        event_away_team: eventData.event_away_team,
                                        away_team_key: eventData.away_team_key,
                                        home_team_key: eventData.home_team_key)
                
                teams.append(teamInfo)
            }
            self.teamResultList = teams
            print("team info: \(teamResultList)") // Verify teamResultList after updating
        } else {
            print("latestResultsList is nil")
        }
    }

}
