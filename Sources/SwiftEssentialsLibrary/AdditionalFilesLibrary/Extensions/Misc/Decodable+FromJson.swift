//
//  Decodable+FromJson.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/29.
//

import Foundation

extension Decodable {
    
    static func fromJson(_ json: Any?) throws -> Self {
        guard let json = json as? [String:Any] else { 
            print("ERROR: trying to extract json from a non-json object")
            throw NSError.init()
        }
        return try JSONDecoder().decode(Self.self, from: JSONSerialization.data(withJSONObject: json as Any, options: []))
    }
    
}
