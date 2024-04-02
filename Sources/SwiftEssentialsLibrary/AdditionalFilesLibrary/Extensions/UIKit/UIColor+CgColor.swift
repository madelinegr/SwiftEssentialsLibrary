//
//  UIColor+CgColor.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/14.
//

import UIKit

extension UIColor {
    func toCGColor(in colorSpace: CGColorSpace) -> CGColor? {
        // Convert UIColor to RGBA components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Define the components in an array
        let components = [red, green, blue, alpha]
        
        // Create a CGColor with the specified color space
        return CGColor(colorSpace: colorSpace, components: components)
    }
}
