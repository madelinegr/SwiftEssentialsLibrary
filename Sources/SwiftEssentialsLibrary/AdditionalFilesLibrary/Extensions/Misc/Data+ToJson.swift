//
//  Data+ToJson.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/29.
//

import Foundation

extension Data {
    
    func toJson() throws -> [String: Any] {
        return try (JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]).unwrapOrThrow()
    }
    
}
