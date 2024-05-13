//
//  EventData.swift
//  SportsApp
//
//  Created by Salma on 12/05/2024.
//



import Foundation

class EventData: NSObject, Codable {
    var event_date: String?
    var event_time: String?
    var league_name: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var event_home_team: String?
    var event_away_team: String?
}

/*
 //date
 //time
 //eventname
 //homeTeamLogo, awayTeamLogo: String
 //eventHomeTeam name
 //eventAwayTeam

 */

/*
let eventKey: Int
 let evenDate: String?
 let eventTime: EventTime
 let eventHomeTeam: String
 let homeTeamKey: Int
 let eventAwayTeam: String
 let awayTeamKey: Int
 let eventHalftimeResult, eventFinalResult, eventFtResult: String
 let eventPenaltyResult: EventPenaltyResult
 let eventStatus: EventStatus
 let countryName: CountryName
 let leagueName: LeagueName
 let leagueKey: Int
 let leagueRound: LeagueRound
 let leagueSeason: LeagueSeason
 let eventLive, eventStadium, eventReferee: String
 let homeTeamLogo, awayTeamLogo: String
 let eventCountryKey: Int
 let leagueLogo, countryLogo: String
 let eventHomeFormation, eventAwayFormation: String
 let fkStageKey: Int
 let stageName: LeagueRound
 let leagueGroup: JSONNull?
 let goalscorers: [[String: String?]]
 let substitutes: [Substitute]
 let cards: [CardElement]
 let vars: Vars
 let lineups: Lineups
 let statistics: [Statistic]
 let eventDate: String?

*/



