//
//  TeamData.swift
//  SportsApp
//
//  Created by Salma on 14/05/2024.
//

import Foundation

class TeamData {
    var home_team_logo: String?
    var away_team_logo: String?
    var event_home_team: String?
    var event_away_team: String?
    var away_team_key: Int?
    var home_team_key: Int?
    
    init(home_team_logo: String? = nil, away_team_logo: String? = nil, event_home_team: String? = nil, event_away_team: String? = nil, away_team_key: Int? = nil, home_team_key: Int? = nil) {
        self.home_team_logo = home_team_logo
        self.away_team_logo = away_team_logo
        self.event_home_team = event_home_team
        self.event_away_team = event_away_team
        self.away_team_key = away_team_key
        self.home_team_key = home_team_key
    }
}
