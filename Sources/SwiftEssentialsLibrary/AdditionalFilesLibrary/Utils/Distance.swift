//
//  Map.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

extension Double {
    
    func convertLatDeltaToKms(_ latDelta: Double) -> Double {
        return latDelta * 69 * 1.6
    }
    
    func metersToFeet() -> Double {
        return self * 3.280839895
    }

    func feetToMiles() -> Double {
        return self / 5280
    }
    
}
        
