//
//  UIView+BlurEffect.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/11.
//

import UIKit

public extension UIView {
    func applyBlurEffect(_ style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
    }
}
