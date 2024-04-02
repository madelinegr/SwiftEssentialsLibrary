//
//  UITextView+AnimateTextr.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/06.
//

import UIKit
import CoreHaptics

extension UITextView {
    func animate(newText: NSAttributedString, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
        let oldText = self.attributedText?.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString()
        if forward {
            let allText = oldText.mutableCopy() as! NSMutableAttributedString
            allText.append(newText)
            var characterIndex = oldText.string.count

            Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                guard characterIndex < allText.string.count else {
                    timer.invalidate()
                    completion()
                    return
                }
                
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                let stringToAppend = allText.attributedSubstring(from: NSRange(location: characterIndex, length: 1))
                oldText.append(stringToAppend)
                self.attributedText = oldText
                characterIndex += 1
            }
        } else {
            var characterIndex = self.text?.count ?? 0

            Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                guard characterIndex > 0 else {
                    timer.invalidate()
                    completion()
                    return
                }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                oldText.deleteCharacters(in: NSRange(location: oldText.length - 1, length: 1))
                self.attributedText = oldText
                characterIndex -= 1
            }
        }
    }
}

class TypewriterUITextView: UITextView {
    
    var timer: Timer?
    var characterIndex = 0
    var mutableAttributedText = NSMutableAttributedString(string: "")
    var extractedLinkAttributes: [(range: NSRange, link: String)] = []
    var completion: (() -> Void)? = nil
    var pauseDurationAtLinebreak: Double? = nil
    
    init() {
//        if #available(iOS 16.0, *) {
//            super.init(usingTextLayoutManager: false) //this is to preserve the link tapping behavior i created
//        } else {
//            super.init(frame: .zero, textContainer: nil)
//        }
        super.init(frame: .zero, textContainer: nil) //super cringe that this isn't working

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .clear
        isEditable = false
        isScrollEnabled = false
        isSelectable = false
    }
    
    func typewriter(newAttributedText: NSAttributedString, characterDelay: TimeInterval, delay: Double? = nil, pauseDurationAtLinebreak: Double? = nil, completion: (() -> Void)? = nil) {

        timer?.invalidate() //Invalidate if we were already typing
        
        self.pauseDurationAtLinebreak = pauseDurationAtLinebreak
        self.characterIndex = 0
        self.extractedLinkAttributes = []
        self.completion = completion
        self.mutableAttributedText = NSMutableAttributedString(attributedString: newAttributedText)

        // Extracting links
        mutableAttributedText.enumerateAttribute(.link, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { (value, range, stop) in
            if let urlString = value as? String {
                extractedLinkAttributes.append((range, urlString))
            }
        }
        mutableAttributedText.removeAttribute(.link, range: NSRange(location: 0, length: mutableAttributedText.string.count))
        
        mutableAttributedText.enumerateAttribute(.foregroundColor, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { value, range, _ in
            mutableAttributedText.addAttribute(.foregroundColor, value: (value as! UIColor).withAlphaComponent(0), range: range)
        }
        self.attributedText = mutableAttributedText
        
        // Use a timer to animate each character
        DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0)) { [self] in
            timer = Timer(timeInterval: characterDelay, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .default)
        }
    }
    
    @objc func handleTimer() {
        guard characterIndex < mutableAttributedText.length else {
            timer?.invalidate()
            for linkAttribute in extractedLinkAttributes {
                mutableAttributedText.addAttributes([.link: linkAttribute.link], range: linkAttribute.range)
            }
            UIView.transition(with: self,duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.attributedText = self.mutableAttributedText
            }, completion: nil)
            completion?() // Call completion block after the animation is finished
            return
        }
        
        // Update the color of the character at the current index
        mutableAttributedText.addAttribute(.foregroundColor,
                                           value: (mutableAttributedText.attribute(.foregroundColor, at: characterIndex, effectiveRange: nil) as! UIColor).withAlphaComponent(1),
                                           range: NSRange(location: characterIndex, length: 1))
        self.attributedText = mutableAttributedText
        
        if mutableAttributedText.string[characterIndex] == "\n", let pauseDurationAtLinebreak {
            pauseTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + pauseDurationAtLinebreak) { [weak self] in
                guard let self else { return }
                self.resumeTimer()
            }
        } else {
            let newCharacter = mutableAttributedText.string[characterIndex]
            if !CharacterSet.newlines.contains(newCharacter.unicodeScalars.first!) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 0.6)
            }
        }
        
        characterIndex += 1
    }

    func pauseTimer() {
        timer?.fireDate = .distantFuture
    }
    
    func resumeTimer() {
        timer?.fireDate = Date()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    //Allow the link to be clicked, otherwise pass the touch through
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let glyphIndex = self.layoutManager.glyphIndex(for: point, in: self.textContainer)

        //Ensure the glyphIndex actually matches the point and isn't just the closest glyph to the point
        let glyphRect = self.layoutManager.boundingRect(forGlyphRange: NSRange(location: glyphIndex, length: 1), in: self.textContainer)

        if glyphIndex < self.textStorage.length,
            glyphRect.contains(point),
           self.textStorage.attribute(NSAttributedString.Key.link, at: glyphIndex, effectiveRange: nil) != nil {
            return self
        } else {
            return nil
        }
    }

    
}
