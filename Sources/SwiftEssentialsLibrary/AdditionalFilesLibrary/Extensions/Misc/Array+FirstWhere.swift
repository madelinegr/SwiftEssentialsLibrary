//
//  Array+FirstWhere.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

public extension Array where Element: Equatable {
     // Remove first collection element that is equal to the given `object`:
     mutating func removeFirstAppearanceOf(object: Element) {
         guard let index = firstIndex(of: object) else {return}
         remove(at: index)
     }
}
