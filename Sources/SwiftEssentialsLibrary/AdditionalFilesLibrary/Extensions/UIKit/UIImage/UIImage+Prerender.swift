//
//  UIImage+Prerender.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/10.
//

import UIKit

public extension UIImage {
    
    func prerender() async -> UIImage {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRectMake(0, 0, size.width, size.height))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
}
