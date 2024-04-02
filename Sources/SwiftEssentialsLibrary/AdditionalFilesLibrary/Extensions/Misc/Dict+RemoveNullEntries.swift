//
//  Dict+RemoveNullEntries.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

extension Dictionary {
    
    func withoutNullEntries() -> Dictionary {
        var noNullDict = self
        for (key, elem) in noNullDict {
            if elem is NSNull { // NSNull is a singleton, so this check is sufficient
                noNullDict.removeValue(forKey: key)
            }
        }
        return noNullDict
    }
}
