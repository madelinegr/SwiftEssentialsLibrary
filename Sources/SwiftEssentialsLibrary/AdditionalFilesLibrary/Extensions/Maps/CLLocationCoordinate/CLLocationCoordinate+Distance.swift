//
//  CLLocationCoordinate+Distance.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    func distanceInMeters(from otherCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let myLocation = CLLocation(latitude: self.latitude,
                                    longitude: self.longitude)
        let otherLocation = CLLocation(latitude: otherCoordinate.latitude,
                                       longitude: otherCoordinate.longitude)
        return myLocation.distance(from: otherLocation)
    }
    
    func distanceInKilometers(from otherCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let myLocation = CLLocation(latitude: self.latitude,
                                    longitude: self.longitude)
        let otherLocation = CLLocation(latitude: otherCoordinate.latitude,
                                       longitude: otherCoordinate.longitude)
        return myLocation.distance(from: otherLocation) / 1000.0
    }
    
    func distanceInMiles(from otherCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let myLocation = CLLocation(latitude: self.latitude,
                                    longitude: self.longitude)
        let otherLocation = CLLocation(latitude: otherCoordinate.latitude,
                                       longitude: otherCoordinate.longitude)
        return myLocation.distance(from: otherLocation) / 1609.34
    }
}
