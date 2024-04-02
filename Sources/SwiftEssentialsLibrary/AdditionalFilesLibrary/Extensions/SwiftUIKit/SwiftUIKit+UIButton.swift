//
//  SwiftUIKit+UIButton.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/10.
//

import UIKit

public extension UIButton {

    @discardableResult
    func sTitle<T: UIButton>(_ text: String) -> T {
        self.setTitle(text, for: .normal)
        return self as! T
    }

    @discardableResult
    func sAttributedTitle<T: UIButton>(_ attributedText: NSAttributedString) -> T {
        self.setAttributedTitle(attributedText, for: .normal)
        return self as! T
    }

    @discardableResult
    func sTitleColor<T: UIButton>(_ color: UIColor) -> T {
        self.setTitleColor(color, for: .normal)
        return self as! T
    }
    
    @discardableResult
    func sFont<T: UIButton>(_ font: UIFont) -> T {
        self.titleLabel?.font = font
        return self as! T
    }

    @discardableResult
    func sImage<T: UIButton>(_ image: UIImage) -> T {
        self.setImage(image, for: .normal)
        return self as! T
    }

    @discardableResult
    func sTarget<T: UIButton>(target: Any?, action: Selector, for event: UIControl.Event = .touchUpInside) -> T {
        self.addTarget(target, action: action, for: event)
        return self as! T
    }
    
}

