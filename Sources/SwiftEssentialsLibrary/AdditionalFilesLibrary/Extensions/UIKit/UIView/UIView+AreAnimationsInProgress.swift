//
//  UIView+AreAnimationsInProgress.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

public extension UIView {
    
    static var areAnimationsInProgress: Bool {
        return UIView.inheritedAnimationDuration > 0
    }
}
