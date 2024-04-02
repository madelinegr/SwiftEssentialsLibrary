//
//  Array+InsertionIndex.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/28/24.
//

import Foundation

extension RandomAccessCollection where Element : Comparable {
    func insertionIndex(of value: Element) -> Index {
        var slice : SubSequence = self[...]

        while !slice.isEmpty {
            let middle = slice.index(slice.startIndex, offsetBy: slice.count / 2)
            if value < slice[middle] {
                slice = slice[..<middle]
            } else {
                slice = slice[index(after: middle)...]
            }
        }
        return slice.startIndex
    }
}

extension RandomAccessCollection { // the predicate version is not required to conform to Comparable
    func insertionIndex(for predicate: (Element) -> Bool) -> Index {
        var slice : SubSequence = self[...]

        while !slice.isEmpty {
            let middle = slice.index(slice.startIndex, offsetBy: slice.count / 2)
            if predicate(slice[middle]) {
                slice = slice[index(after: middle)...]
            } else {
                slice = slice[..<middle]
            }
        }
        return slice.startIndex
    }
}
