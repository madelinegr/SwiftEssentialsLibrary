//
//  File.swift
//  
//
//  Created by Adam Novak on 4/22/24.
//

import Foundation

public extension RandomAccessCollection where Index == Int {
    func next(after index: Index) -> Element? {
        guard !isEmpty else { return nil } // Return nil if the collection is empty
        let nextIndex = index + 1
        return nextIndex < count ? self[nextIndex] : self[startIndex]
    }
}
