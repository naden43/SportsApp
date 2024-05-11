//
//  NetworkHandlerProtocol.swift
//  SportsApp
//
//  Created by Naden on 12/05/2024.
//

import Foundation


protocol NetworkHandlerProtocol {
    
    
    func loadData<T: Decodable>(onCompletion: @escaping (T) -> Void , url: String)
    
}
