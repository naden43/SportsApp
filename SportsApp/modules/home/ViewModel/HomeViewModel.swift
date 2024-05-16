//
//  HomeViewModel.swift
//  SportsApp
//
//  Created by Salma on 13/05/2024.
//

import Foundation

class HomeViewModel{
    
    var selectedSport:String?
    
    // Dummy data array
    let sports: [Sport] = [
        Sport(name: "football", imageName: "football_2"),
        Sport(name: "basketball", imageName: "basketball_2"),
        Sport(name: "tennis", imageName: "tennis_1"),
        Sport(name: "cricket", imageName: "cricket-2")
    ]
    
    func getSportsCount()->Int{
        return sports.count
    }
    
    func getSportAtIndex(index:Int)->Sport{
        return sports[index]
        
    }
    
    func setSelectedSport(index:Int){
        selectedSport = sports[index].name
    }
    
    func getSelectedSport()->String{
         return selectedSport!
    }
    

}
