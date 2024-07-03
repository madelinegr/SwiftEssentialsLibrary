//
//  Array+NextNElementsWrapping.swift
//  
//
//  Created by Adam Novak on 7/3/24.
//

import Foundation

extension Array {
    public func nextNElementsWrapping(fromIndex currentIndex: Int, count: Int) -> [Element] {
        guard !self.isEmpty else { return [] }
        
        var result = [Element]()
        let totalElements = self.count

        for i in 0..<count {
            let index = (currentIndex + i) % totalElements
            result.append(self[index])
        }

        return result
    }
    
    public func previousNElementsWrapping(fromIndex currentIndex: Int, count: Int) -> [Element] {
        guard !self.isEmpty else { return [] }
        
        var result = [Element]()
        let totalElements = self.count

        for i in 0..<count {
            let index = (currentIndex - i + totalElements) % totalElements
            result.append(self[index])
        }

        return result
    }
}
