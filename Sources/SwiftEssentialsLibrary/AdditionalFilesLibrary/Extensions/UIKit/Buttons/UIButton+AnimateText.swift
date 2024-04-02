//
//  UIButton+AnimateText.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/06.
//

import UIKit

extension UIButton {
    func animate(newText: String, characterDelay: TimeInterval, forward: Bool, completion: @escaping () -> Void) {
        if forward {
            var oldText = self.title(for: .normal) ?? ""
            var characterIndex = 0

            Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                guard characterIndex < newText.count else {
                    timer.invalidate()
                    completion()
                    return
                }

                let index = newText.index(newText.startIndex, offsetBy: characterIndex)
                oldText.append(newText[index])
                self.setTitle(oldText, for: .normal)
                self.layoutIfNeeded()
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                characterIndex += 1
            }
        } else {
             var oldText = self.title(for: .normal) ?? ""
             var characterIndex = oldText.count

             Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { timer in
                 guard characterIndex > 0 else {
                     timer.invalidate()
                     completion()
                     return
                 }

                 oldText = String(oldText.dropLast())
                 self.setTitle(oldText, for: .normal)
                 self.layoutIfNeeded()
                 UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                 characterIndex -= 1
             }
         }
     }
 }
