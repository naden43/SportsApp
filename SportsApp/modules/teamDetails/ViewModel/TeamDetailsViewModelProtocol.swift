//
//  TeamDetailsViewModelProtocol.swift
//  SportsApp
//
//  Created by Salma on 14/05/2024.
//

import Foundation

import Foundation

protocol TeamDetailsViewModelProtocol {
    
    func implementBindTeamDetailsToList(bindTeamDetailsToList: @escaping ()-> Void)
    func getTeamsListCount() -> Int
    func loadTeamDetails()
    func getTeamDetailsAtIndex(index: Int) -> Team?
    
}
