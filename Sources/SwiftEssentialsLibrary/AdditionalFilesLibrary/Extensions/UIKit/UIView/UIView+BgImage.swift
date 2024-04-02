//
//  UIView+BgImage.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/02.
//

import UIKit

public extension UIView {
    
    ///Note: the view must already have its bounds properly defined when this is called (eg don't call this on the same cycle you're setting up constraints)
    func setBackgroundImage(_ image: UIImage) {
        UIGraphicsBeginImageContext(self.frame.size)
        image.draw(in: self.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor(patternImage: image)
        } else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
    }
    
}
