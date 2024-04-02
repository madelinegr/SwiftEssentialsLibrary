//
//  Int+OrdinalSuffix.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/8/24.
//

import Foundation

extension Int {
    var ordinalSuffix: String {
        let ones = self % 10
        let tens = (self / 10) % 10
        if tens == 1 {
            return "th"
        }
        switch ones {
        case 1: return "st"
        case 2: return "nd"
        case 3: return "rd"
        default: return "th"
        }
    }
}
