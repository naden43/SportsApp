//
//  FavouriteSportsDataSource.swift
//  SportsApp
//
//  Created by Salma on 13/05/2024.
//

import Foundation

import UIKit
import CoreData

class FavouriteSportsDataSource {
    
    static let shared = FavouriteSportsDataSource()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    private init() {}
    
    func addFavLeague(league:LeagueData) {
        let favouriteLeaguesEntity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: context)!
        let leagueObj = NSManagedObject(entity: favouriteLeaguesEntity, insertInto: context)
        
        leagueObj.setValue(league.league_name, forKey: "league_name")
        leagueObj.setValue(league.league_key, forKey: "league_key")
        leagueObj.setValue(league.league_logo, forKey: "league_logo")
        leagueObj.setValue(league.sport_name, forKey: "sport_name")
        
        
        
        do {
            try context.save()
            print("league Added!")
        } catch {
            print("Error saving league: \(error.localizedDescription)")
        }
    }
}
