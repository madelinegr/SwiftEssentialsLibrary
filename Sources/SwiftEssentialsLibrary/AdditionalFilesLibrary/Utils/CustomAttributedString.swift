//
//  AttributedString.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

struct CustomAttributedString {
    static func createFor(text: String, fontName: String, size: CGFloat) -> NSMutableAttributedString {
        let customAttributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: size)!]
        return NSMutableAttributedString(string: text, attributes: customAttributes)
    }
}
