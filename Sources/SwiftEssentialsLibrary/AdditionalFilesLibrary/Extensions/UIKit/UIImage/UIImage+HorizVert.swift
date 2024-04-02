//
//  UIImage+HorizVert.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/10.
//

import UIKit

public extension UIImage {
    
    func rotatedAsWidest() -> UIImage {
        return self.size.width > self.size.height ? self : self.rotate(radians: Float(-90.degreesToRadians))!
    }
    
    func rotatedAsTallest() -> UIImage {
        return self.size.height > self.size.width ? self : self.rotate(radians: Float(90.degreesToRadians))!
    }
    
}
