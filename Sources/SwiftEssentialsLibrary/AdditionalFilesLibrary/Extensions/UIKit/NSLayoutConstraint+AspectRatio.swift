//
//  NSLayoutConstraint+AspectRatio.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/10/17.
//

import UIKit

public extension UIView {
    
    func aspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
