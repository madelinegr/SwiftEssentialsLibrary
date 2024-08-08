//
//  StringArray+Comma&.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/10/30.
//

import Foundation

public extension Array<String> {
    
    func asCommaAndString() -> String {
        var string = ""
        for i in 0..<self.count {
            string += self[i]
            if i < self.count-1 {
                if i == self.count-2 {
                    string += " & "
                } else {
                    string += ", "
                }
            }
        }
        return string
    }
    
    func asCommaSeparatedString() -> String {
        var string = ""
        for i in 0..<self.count {
            string += self[i]
            if i < self.count-1 {
                string += ", "
            }
        }
        return string
    }
    
}
