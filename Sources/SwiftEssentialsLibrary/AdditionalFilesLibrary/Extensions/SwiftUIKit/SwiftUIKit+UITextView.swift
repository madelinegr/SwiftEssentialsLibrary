//
//  UIKitAndSwiftUIHybrid.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/01.
//

import UIKit

public extension UITextView {

    @discardableResult
    func sText<T: UITextView>(_ text: String) -> T {
        self.text = text
        return self as! T
    }

    @discardableResult
    func sTextColor<T: UITextView>(_ textColor: UIColor) -> T {
        self.textColor = textColor
        return self as! T
    }

    @discardableResult
    func sFont<T: UITextView>(_ font: UIFont) -> T {
        self.font = font
        return self as! T
    }

    @discardableResult
    func sAttributedText<T: UITextView>(_ attributedText: NSAttributedString) -> T {
        self.attributedText = attributedText
        return self as! T
    }

}
