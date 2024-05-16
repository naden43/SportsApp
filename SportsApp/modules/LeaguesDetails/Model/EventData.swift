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
    var event_final_result: String?
    var away_team_key: Int?
    var home_team_key: Int?
    
}





