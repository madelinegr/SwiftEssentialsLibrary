//
//  String+FirstLastInitial.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 3/11/24.
//

import Foundation

public extension String {
    var firstLastInitial: String {
        let nameComponents = self.split(separator: " ").map(String.init) // Split the name into components
        guard !nameComponents.isEmpty else { return "" } // Check if the name is empty
        let firstName = nameComponents[0] // The first component is always the first name
        if nameComponents.count > 1 {
            let lastNameInitial = nameComponents.last?.first.map(String.init) ?? "" // Get the initial of the last name if it exists
            return "\(firstName) \(lastNameInitial)" // Combine the first name and last name initial
        } else {
            return firstName // If there's only a first name, return it
        }
    }
}
