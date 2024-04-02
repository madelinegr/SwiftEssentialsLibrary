//
//  TappableTextView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/10/17.
//

import UIKit

class TappableTextView: UITextView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let pos = closestPosition(to: point) else { return false }
        guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: .layout(.left)) else { return false }
        let startIndex = offset(from: beginningOfDocument, to: range.start)
        return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
    }
    
}
