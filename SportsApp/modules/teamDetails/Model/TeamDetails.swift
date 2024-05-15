//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Salma on 14/05/2024.
//

import Foundation


struct TeamDetails:  Codable  {
    let success: Int?
    var result: [Team]?
}

struct Team: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
}

struct Player: Codable {
    let player_image: String?
    let player_name: String?
    
}
