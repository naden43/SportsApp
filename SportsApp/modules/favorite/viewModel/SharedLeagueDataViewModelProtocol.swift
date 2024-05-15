//
//  File.swift
//  SportsApp
//
//  Created by Naden on 14/05/2024.
//

import Foundation

protocol SharedLeagueDataViewModelProtocol {
    
    func setSelectedLeague(index:Int)
    func getSelectedLeague()-> LeagueData
    
}
