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
    
    let entityName = "FavouriteLeagues"
    
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
    
    
    // core data part ( delete , retrive , select )
    func deleteFavLeague(league:LeagueData){
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        
        let predicate = "league_key == %d AND sport_name == %@"
        
        fetchRequest.predicate = NSPredicate(format: predicate, league.league_key!, league.sport_name!)

        do {
            if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
                context.delete(result)
                try context.save()
            } else {
                print("No matching object found in Core Data for league_key")
            }
        } catch {
            print("Error deleting object: \(error)")
        }
        
        
        
    }
    
    func retriveFavLeagues(onComplition:@escaping (([LeagueData]) -> Void))
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        var resultLeaguesList : [LeagueData] = []
        DispatchQueue.global().async {
            
            do {
                let result = try self.context.fetch(fetchRequest)
                
                for item in result {
                    let league = self.convertToLeaguData(league: item)
                    resultLeaguesList.append(league)
                }
                
                DispatchQueue.main.async {
                    onComplition(resultLeaguesList)
                }
            }
            catch let error {
                DispatchQueue.main.sync {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // edit this function later
    func selectSpecificLeague(league:LeagueData) -> LeagueData?{
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        
        let predicate = "league_key == %d AND sport_name == %@"
        
        fetchRequest.predicate = NSPredicate(format: predicate, league.league_key!, league.sport_name!)

        do {
            if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
                     return convertToLeaguData(league: result)
                }
        } catch {
            print("Error deleting object: \(error)")
        }
        
        return nil
    }
    
    func convertToLeaguData(league:NSManagedObject) -> LeagueData{
        let resultLeague : LeagueData = LeagueData()
        
        resultLeague.league_key = league.value(forKey: "league_key") as? Int
        resultLeague.league_logo = league.value(forKey: "league_logo") as? String
        resultLeague.league_name = league.value(forKey: "league_name") as? String
        resultLeague.sport_name = league.value(forKey: "sport_name") as? String
        
        return resultLeague
    }
}
