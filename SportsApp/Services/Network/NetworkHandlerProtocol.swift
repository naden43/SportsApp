//
//  NetworkHandlerProtocol.swift
//  SportsApp
//
//  Created by Naden on 12/05/2024.
//

import Foundation
 
 
protocol NetworkHandlerProtocol {
    
    
    func loadData<T: Decodable>(url : String  , onCompletion: @escaping (T?, Error?) -> Void)
 
    
}
