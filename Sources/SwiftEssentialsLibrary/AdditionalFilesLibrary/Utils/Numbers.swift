//
//  Numbers.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

//Examples: 4, 42, 423, 4.2k, 42k, 423k
//This code is not meant to handle over a million emoji reactions on one single post... let's not get too popular
public func formattedVoteCount(_ number: Double) -> String {
    var formatted: String = ""
    if number < 1_000 {
        formatted = String(Int(number))
    } else if number < 10_000 {
        let k = number/1000.0
//        let firstDecimal = Int(number / 100) % Int(floor(number) / 100)
        formatted = String(k).prefix(3) + "k"
    } else if number < 100_000 {
        let k = number/1000.0
        formatted = String(k).prefix(2) + "k"
    } else if number < 1_000_000 {
        let k = number/1000.0
        formatted = String(k).prefix(3) + "k"
    }
    return formatted
}

public func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(CGFloat.pi / 180)
}

public extension Double {
    
    func formatToTwoDecimalPlaces() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
