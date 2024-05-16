//
//  MockNetworkHandler.swift
//  Testing_lab2Tests
//
//  Created by Naden on 14/05/2024.
//

import Foundation
@testable import SportsApp

class MockNetworkHandler {
    
    
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    enum responseError : Error {
        
        case error
    }
    
    let fakeJsonObj: [String: Any] = [
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                "country_logo": nil
            ]
        ]
    ]

    
    func loadData<T:Decodable>(onComplition : @escaping ((T? , Error?)->Void)){
        
        
        var result = League()
        
        do {
            
            let data  = try JSONSerialization.data(withJSONObject: fakeJsonObj)
            
            result = try JSONDecoder().decode(T.self, from: data) as! League
            
        }catch let error {
            
            print(error.localizedDescription)
        }
        
        
      
        
        if shouldReturnError {
            
            onComplition(nil , responseError.error)
        }
        else {
            print("here")
            onComplition(result as? T, nil)
        }
    
    }
}
