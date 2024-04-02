//
//  UILabel+CharSpacing.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/04.
//

import UIKit

extension UILabel {
    
  func addCharacterSpacing(kernValue: Double = 1.15) {
    guard let text = text, !text.isEmpty else { return }
    let string = NSMutableAttributedString(string: text)
    string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
    attributedText = string
  }
    
}

extension String {
    
    func addCharacterSpacing(kernValue: Double = 1.15) -> NSAttributedString {
        let string = NSMutableAttributedString(string: self)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        return string
    }
    
}
