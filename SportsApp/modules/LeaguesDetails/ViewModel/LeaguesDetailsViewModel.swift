//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Salma on 12/05/2024.
//


import Foundation

class LeaguesDetailsViewModel: LeaguesDetailsViewModelProtocol {
    
    let network: NetworkHandlerProtocol
    var bindLeagueDetailsToList: () -> Void = {}
    var upcomingEventsEndPoint: String?
    var latestResultsEndPoint: String?
    var upcomingEventList: [EventData]?
    var latestResultsList: [EventData]?
    var startDate: String?
    var stopDate: String?
  
    init(network: NetworkHandler, mySelectedSport: String, myleagueId: String) {
        self.network = network
        getEndPointOfUpcomingEvents(selectedSport: mySelectedSport, leagueId: myleagueId)
        print("upcomingEventsEndPoint \(upcomingEventsEndPoint)")
        getEndPointOfLatestResults(selectedSport: mySelectedSport, leagueId:myleagueId)
        
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

    func getUpcomingEventAtIndex(index: Int) -> EventData? {
        return upcomingEventList?[index]
    }

    func getLatestResultsAtIndex(index: Int) -> EventData? {
        return latestResultsList?[index]
    }

    func loadUpcomingEvents() {
         network.loadData(onCompletion: { [weak self] (upcomingEventList:Event) in
             
             self?.upcomingEventList = upcomingEventList.result
             
             self?.bindLeagueDetailsToList()
             
         }, url: upcomingEventsEndPoint ?? "football?met=Fixtures&leagueId=205&from=2023-05-18&to=2024-05-18")
     }
     
     
     func loadLatestResults() {
         network.loadData(onCompletion: { [weak self] (latestResultsList: Event) in
             
             self?.latestResultsList = latestResultsList.result
             self?.bindLeagueDetailsToList()
             
         }, url : latestResultsEndPoint ??  "football?met=Fixtures&leagueId=205&from=2023-05-18&to=2024-05-18")
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
}
