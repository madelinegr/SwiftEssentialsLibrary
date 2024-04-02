//
//  SwiftUIKit+UILabel.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/12.
//

import UIKit

public extension UILabel {

    @discardableResult
    func sText<T: UILabel>(_ text: String) -> T {
        self.text = text
        return self as! T
    }
    
    @discardableResult
    func sAttributedText<T: UILabel>(_ attributedText: NSAttributedString) -> T {
        self.attributedText = attributedText
        return self as! T
    }

    @discardableResult
    func sTextColor<T: UILabel>(_ textColor: UIColor) -> T {
        self.textColor = textColor
        return self as! T
    }

    @discardableResult
    func sNumberOfLines<T: UILabel>(_ numberOfLines: Int) -> T {
        self.numberOfLines = numberOfLines
        return self as! T
    }

    @discardableResult
    func sFont<T: UILabel>(_ font: UIFont) -> T {
        self.font = font
        return self as! T
    }
    
    @discardableResult
    func sTextAlignment<T: UILabel>(_ textAlignment: NSTextAlignment) -> T {
        self.textAlignment = textAlignment
        return self as! T
    }

}
