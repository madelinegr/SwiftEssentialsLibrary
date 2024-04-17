
/*
From apple

Abstract:
A utility file to provide icons for point-of-interest categories.
*/

import Foundation
import MapKit

public extension MKPointOfInterestCategory {
    
    static let travelPointsOfInterest: [MKPointOfInterestCategory] = [.bakery, .brewery, .cafe, .restaurant, .winery, .hotel]
    static let defaultSymbolUIImage = UIImage(systemName: "mappin.and.ellipse")!
    
    var displayName: String {
        switch self {
        case .airport:
            return "Airport"
        case .atm:
            return "ATM"
        case .bank:
            return "Bank"
        case .brewery:
            return "Brewery"
        case .winery:
            return "Winery"
        case .restaurant:
            return "Restaurant"
        case .nightlife:
            return "Nightlife"
        case .foodMarket:
            return "Food Market"
        case .store:
            return "Store"
        case .bakery:
            return "Bakery"
        case .cafe:
            return "Cafe"
        case .campground:
            return "Campground"
        case .hotel:
            return "Hotel"
        case .pharmacy:
            return "Pharmacy"
        case .carRental:
            return "Car Rental"
        case .gasStation:
            return "Gas Station"
        case .evCharger:
            return "EV Charger"
        case .laundry:
            return "Laundry"
        case .university:
            return "University"
        case .school:
            return "School"
        case .library:
            return "Library"
        case .parking:
            return "Parking"
        case .theater:
            return "Theater"
        case .marina:
            return "Marina"
        case .museum:
            return "Museum"
        case .nationalPark:
            return "National Park"
        case .park:
            return "Park"
        case .postOffice:
            return "Post Office"
        case .publicTransport:
            return "Public Transport"
        default:
            return "Unknown Category"
        }
    }
    
    var symbolUIImage: UIImage {
        switch self {
        case .airport:
            return UIImage(systemName: "airplane")!
        case .atm, .bank:
            return UIImage(systemName: "banknote")!
        case .brewery, .winery, .restaurant:
            return UIImage(systemName: "fork.knife")!
        case .nightlife:
            return UIImage(systemName: "moon")!
        case .foodMarket, .store:
            return UIImage(systemName: "cart")!
        case .bakery, .cafe:
            return UIImage(systemName: "cup.and.saucer")!
        case .campground, .hotel:
            return UIImage(systemName: "bed.double")!
        case .pharmacy:
            return UIImage(systemName: "pills")!
        case .carRental, .gasStation:
            return UIImage(systemName: "car")!
        case .evCharger:
            return UIImage(systemName: "bolt.car")!
        case .laundry, .store:
            return UIImage(systemName: "tshirt")!
        case .university, .school:
            return UIImage(systemName: "graduationcap")!
        case .library:
            return UIImage(systemName: "book")!
        case .parking:
            return UIImage(systemName: "p.circle")!
        case .theater:
            return UIImage(systemName: "theatermasks")!
        case .marina:
            return UIImage(systemName: "ferry")!
        case .museum:
            return UIImage(systemName: "building.columns")!
        case .nationalPark, .park:
            return UIImage(systemName: "leaf")!
        case .postOffice:
            return UIImage(systemName: "envelope")!
        case .publicTransport:
            return UIImage(systemName: "bus")!
        default:
            return UIImage(systemName: "mappin.and.ellipse")!
        }
    }
}
