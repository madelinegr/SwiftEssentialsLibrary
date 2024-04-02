//
//  JSONEncoder+Subset.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/09/28.
//

import Foundation

public extension CodingUserInfoKey {
    static let keysToEncode = CodingUserInfoKey(rawValue: "keysToEncode")!
}

public extension JSONEncoder {
    func withEncodeSubset<CodingKeys>(keysToEncode: Set<CodingKeys>) -> JSONEncoder {
        userInfo[.keysToEncode] = Array(keysToEncode)
        return self
    }
}
