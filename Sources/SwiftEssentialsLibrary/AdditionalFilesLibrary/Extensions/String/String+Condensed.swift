//
//  String+Condensed.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

public extension String {

    /// Returns a condensed string, with no extra whitespaces and no new lines.
    var condensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }

    /// Returns a condensed string, with no whitespaces at all and no new lines.
    var extraCondensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
    }

}
