//
//  AnimateText.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/27.
//

import UIKit

func animate(textView: UITextView, newText: NSAttributedString, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
    let oldText = textView.attributedText?.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString()
    if forward {
        let allText = oldText.mutableCopy() as! NSMutableAttributedString
        allText.append(newText)
        textView.attributedText = allText

        var characterIndex = oldText.string.count

        Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex < allText.string.count else {
                timer.invalidate()
                completion()
                return
            }
            
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            let stringToAppend = allText.attributedSubstring(from: NSRange(location: characterIndex, length: 1))
            oldText.append(stringToAppend)
            textView.attributedText = oldText
            characterIndex += 1
        }
    } else {
        var characterIndex = textView.text?.count ?? 0

        Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex > 0 else {
                timer.invalidate()
                completion()
                return
            }
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            oldText.deleteCharacters(in: NSRange(location: oldText.length - 1, length: 1))
            textView.attributedText = oldText
            characterIndex -= 1
        }
    }
}

func animate(label: UILabel, newText: NSAttributedString, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
    if forward {
        let oldText = label.attributedText ?? NSAttributedString(string: "")
        let allText = NSMutableAttributedString()
        allText.append(oldText)
        allText.append(newText)
        
        var characterIndex = oldText.length
        
        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex < allText.length else {
                timer.invalidate()
                completion()
                return
            }
            
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            let range = NSRange(location: characterIndex, length: 1)
            let nextChar = allText.attributedSubstring(from: range)
            label.attributedText = label.attributedText?.adding(nextChar)
            characterIndex += 1
        }
    } else {
        var characterIndex = label.attributedText?.length ?? 0
        
        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex > 0 else {
                timer.invalidate()
                completion()
                return
            }
            
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            label.attributedText = label.attributedText?.removingLast()
            characterIndex -= 1
        }
    }
}

extension NSAttributedString {
    func adding(_ other: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(self)
        result.append(other)
        return result
    }
    
    func removingLast() -> NSAttributedString {
        guard length > 0 else {
            return self
        }
        return attributedSubstring(from: NSRange(location: 0, length: length - 1))
    }
}

func animate(label: UILabel, newText: String, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
    if forward {
        let oldText = label.text ?? ""
        let allText = oldText + newText
        label.text = oldText

        var characterIndex = oldText.count

        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex < allText.count else {
                timer.invalidate()
                completion()
                return
            }

            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            let index = allText.index(allText.startIndex, offsetBy: characterIndex)
            label.text?.append(allText[index])
            characterIndex += 1
        }
    } else {
        var characterIndex = label.text?.count ?? 0

        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex > 0 else {
                timer.invalidate()
                completion()
                return
            }
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            label.text = String(label.text?.dropLast() ?? "")
            characterIndex -= 1
        }
    }
}


func animate(button: UIButton, newText: String, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
    if forward {
        var oldText = button.title(for: .normal) ?? ""
        var characterIndex = 0

        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex < newText.count else {
                timer.invalidate()
                completion()
                return
            }

            let index = newText.index(newText.startIndex, offsetBy: characterIndex)
            oldText.append(newText[index])
            print("oldtext", oldText)
            button.setTitle(oldText, for: .normal)
            button.layoutIfNeeded()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            characterIndex += 1
        }
    } else {
        var oldText = button.title(for: .normal) ?? ""
        var characterIndex = oldText.count

        _ = Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
            guard characterIndex > 0 else {
                timer.invalidate()
                completion()
                return
            }

            oldText = String(oldText.dropLast())
            button.setTitle(oldText, for: .normal)
            button.layoutIfNeeded()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            characterIndex -= 1
        }
    }
}



extension UIButton {
    func animateImageIn(duration: TimeInterval) {
        guard let imageView = self.imageView else { return }

        // Set the initial state
        imageView.alpha = 0.0
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        // Animate to the final state
        UIView.animate(withDuration: duration) {
            imageView.alpha = 1.0
            imageView.transform = .identity
        }
    }

    func animateImageOut(duration: TimeInterval) {
        guard let imageView = self.imageView else { return }

        // Animate to the final state
        UIView.animate(withDuration: duration, animations: {
            imageView.alpha = 0.0
            imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            imageView.image = nil
        }
    }
}
