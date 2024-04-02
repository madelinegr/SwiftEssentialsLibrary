//
//  UIScrollView+ToTop.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: animated)
        
//        setContentOffset(.zero, animated: true)
        //not sure if this above is any different^?
   }
}

extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
