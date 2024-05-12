//
//  test.swift
//  SportsApp
//
//  Created by Naden on 12/05/2024.
//

import Foundation

protocol LeaguesViewModelProtocol {
    
    func implementBindLenguesToList(bindLenguesToList: @escaping ()-> Void)
    func getLeaguesCount() -> Int
    func getLeagueAtIndex(index:Int) -> LeagueData?
    func loadLeagues()
    
}
