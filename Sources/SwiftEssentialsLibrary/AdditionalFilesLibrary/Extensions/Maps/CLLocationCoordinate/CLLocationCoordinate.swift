//
//  CLLocationCoordinate.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}
