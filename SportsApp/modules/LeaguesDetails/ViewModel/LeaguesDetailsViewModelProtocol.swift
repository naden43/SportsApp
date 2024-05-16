//
//  LeaguesDetailsViewModelProtocol.swift
//  SportsApp
//
//  Created by Salma on 12/05/2024.
//


import Foundation

protocol LeaguesDetailsViewModelProtocol {
    
    func implementBindLeagueDetailsToList(bindLeagueDetailsToList: @escaping ()-> Void)
    func getUpcomingEventsCount() -> Int
    func getLatestResultsCount() -> Int
    func getTeamsListCount() -> Int
    func getSelectedLeague()->LeagueData
    func getSectionCount() -> Int 
    func getUpcomingEventAtIndex(index:Int) -> EventData?
    func loadUpcomingEvents()
    func getLatestResultsAtIndex(index:Int) -> EventData?
    func getTeamsOfLeagueAtIndex(index: Int) -> TeamData?
    func setSelectedTeam(index : Int)
    func getSelectedTeam()->TeamData
    func loadLatestResults()
    func checkFavState() -> Bool
    func addLeagueToFav()
    func getTeamInfo()
    func deleteLeagueFromFav()
    func checkReachability() -> Bool
    
}
