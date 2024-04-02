//
//  UIView+BecomeRound.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIView {
    
    public func becomeRound() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.cornerCurve = .continuous
    }
    
}

extension UIView {
    
    public func roundCornersViaCornerRadius(radius: CGFloat) {
        layer.cornerCurve = .continuous
        layer.cornerRadius = radius
    }
}
