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

    func getUpcomingEventAtIndex(index:Int) -> EventData?
    func loadUpcomingEvents()
    func getLatestResultsAtIndex(index:Int) -> EventData?
    func loadLatestResults()
    func addLeagueToFav()
    
    
}
