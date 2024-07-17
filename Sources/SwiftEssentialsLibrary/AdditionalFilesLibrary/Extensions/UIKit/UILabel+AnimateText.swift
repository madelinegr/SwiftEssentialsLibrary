//
//  UILabel+AnimateText.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/06.
//

import UIKit

public extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval, forward: Bool, completion: (() -> Void)? = nil) {
        if forward {
            let oldText = self.text ?? ""
            let allText = oldText + newText
            self.text = oldText

            var characterIndex = oldText.count

            Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                guard characterIndex < allText.count else {
                    timer.invalidate()
                    completion?()
                    return
                }

                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                let index = allText.index(allText.startIndex, offsetBy: characterIndex)
                self.text?.append(allText[index])
                characterIndex += 1
            }
        } else {
            var characterIndex = self.text?.count ?? 0

            Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                guard characterIndex > 0 else {
                    timer.invalidate()
                    completion?()
                    return
                }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                self.text = String(self.text?.dropLast() ?? "")
                characterIndex -= 1
            }
        }
    }
}

public extension UILabel {
    func typewriter(newAttributedText: NSAttributedString, characterDelay: TimeInterval, impactIntensity: Double? = 0.6, pauseDurationAtLinebreak: Double? = nil, completion: (() -> Void)? = nil) {
        // Set the attributed text with alpha 0 for each character
        let mutableAttributedText = NSMutableAttributedString(attributedString: newAttributedText)
        
        mutableAttributedText.enumerateAttribute(.foregroundColor, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { value, range, _ in
            mutableAttributedText.addAttribute(.foregroundColor, value: (value as! UIColor).withAlphaComponent(0), range: range)
        }
        self.attributedText = mutableAttributedText
        
        // Use a timer to animate each character
        var characterIndex = 0
        let timer = Timer(timeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex < mutableAttributedText.length else {
                timer.invalidate()
                completion?() // Call completion block after the animation is finished
                return
            }
            
            // Update the color of the character at the current index
            mutableAttributedText.addAttribute(.foregroundColor,
                                               value: (mutableAttributedText.attribute(.foregroundColor, at: characterIndex, effectiveRange: nil) as! UIColor).withAlphaComponent(1.0),
                                               range: NSRange(location: characterIndex, length: 1))
            self.attributedText = mutableAttributedText
            
            if mutableAttributedText.string[characterIndex] == "\n", let pauseDurationAtLinebreak {
                timer.fireDate = .distantFuture //pause timer
                DispatchQueue.main.asyncAfter(deadline: .now() + pauseDurationAtLinebreak) {
                    timer.fireDate = Date() //resume timer
                }
            } else {
                let newCharacter = mutableAttributedText.string[characterIndex]
                if let firstScalar = newCharacter.unicodeScalars.first, !CharacterSet.newlines.contains(firstScalar),
                    let impactIntensity {
                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: impactIntensity)
                }
            }
            
            characterIndex += 1
        }
        RunLoop.main.add(timer, forMode: .default)
    }
}

public extension UILabel {
    func typewriter(newText: String, characterDelay: TimeInterval, completion: (() -> Void)? = nil) {
        // Set the text with empty string
        self.text = ""
        
        // Use a timer to animate each character
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { [weak self] timer in
            guard characterIndex < newText.count else {
                timer.invalidate()
                completion?() // Call completion block after the animation is finished
                return
            }

            // Get the substring to append
            let index = newText.index(newText.startIndex, offsetBy: characterIndex)
            let substring = newText[index...index]
           
            self?.text?.append(contentsOf: substring)
            
            let newCharacter = substring
            if !CharacterSet.newlines.contains(newCharacter.unicodeScalars.first!) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 0.4)
            }

            characterIndex += 1
        }
    }
}
