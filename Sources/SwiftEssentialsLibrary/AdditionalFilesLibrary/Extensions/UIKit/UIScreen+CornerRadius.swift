//
//  UIScreen+CornerRadius.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/24/24.
//

import UIKit

extension UIScreen {
    public var cornerRadius: CGFloat {
        guard let cornerRadius = self.value(forKey:"_displayCornerRadius") as? CGFloat else {
            return 0
        }
        return cornerRadius
    }
}
