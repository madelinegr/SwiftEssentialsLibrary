//
//  Array+OptionalIndex.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/10/12.
//

import Foundation

public extension Array {
    func optionalItem(at index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
