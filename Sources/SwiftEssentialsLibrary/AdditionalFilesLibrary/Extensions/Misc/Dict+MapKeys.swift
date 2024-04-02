//
//  Dict+MapKeys.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/07.
//

import Foundation

extension Dictionary {
    func mapKeys<T: Hashable>(_ transform: (Key) throws -> T) rethrows -> Dictionary<T, Value> {
        var newDictionary = Dictionary<T, Value>()

        for (key, value) in self {
            newDictionary[try transform(key)] = value
        }

        return newDictionary
    }
}
