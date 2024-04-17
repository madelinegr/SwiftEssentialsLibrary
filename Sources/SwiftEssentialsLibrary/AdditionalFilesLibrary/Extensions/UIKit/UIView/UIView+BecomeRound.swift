//
//  UIView+BecomeRound.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

public extension UIView {
    
    func becomeRound() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.cornerCurve = .continuous
    }
    
}

public extension UIView {
    
    func roundCornersViaCornerRadius(radius: CGFloat) {
        layer.cornerCurve = .continuous
        layer.cornerRadius = radius
    }
}
