//
//  Encodable+Dict.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return asDictionary[key]
    }
    var asDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
