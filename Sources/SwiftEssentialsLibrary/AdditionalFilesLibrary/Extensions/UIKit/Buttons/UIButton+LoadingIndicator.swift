//
//  UIButton+LoadingIndicator.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

public extension UIButton {
    
    static let LoadingIndicatorTag = 808404
    static let CheckMarkTag = 800904

    var isButtonCustomLoadingIndicatorVisible: Bool {
        get {
            return viewWithTag(UIButton.LoadingIndicatorTag) != nil
        }
    }
    
    enum LoadingPosition {
        case center, left
    }
    func loadingIndicator(_ show: Bool, position: LoadingPosition = .center) {
        if show {
            guard self.viewWithTag(UIButton.LoadingIndicatorTag) == nil else { return } //don't add a loading indicator twice
            self.isEnabled = false
//            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            indicator.color = .white
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            switch position {
            case .center:
                indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            case .left:
                let labelCenterX = self.titleLabel!.center.x
                let labelWidth = self.titleLabel!.intrinsicContentSize.width
//                let indicatorCenterX = buttonWidth/2 - labelWidth/2 - 15 //wasn't as consistent
                indicator.center = CGPoint(x: labelCenterX - labelWidth/2 - 15 , y: buttonHeight/2)
            }
            indicator.tag = UIButton.LoadingIndicatorTag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.imageView?.isHidden = false
            self.isEnabled = true
//            self.alpha = 1.0
            if let indicator = self.viewWithTag(UIButton.LoadingIndicatorTag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    func checkMark(_ show: Bool, position: LoadingPosition = .center) {
        if show {
            guard self.viewWithTag(UIButton.CheckMarkTag) == nil else { return } //don't add a checkmark twice
            self.isEnabled = false
            let checkmark = UIImageView(image: UIImage(systemName: "checkmark"))
            checkmark.tintColor = .white
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            switch position {
            case .center:
                checkmark.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            case .left:
                let labelWidth = self.titleLabel!.intrinsicContentSize.width
                let indicatorCenterX = buttonWidth/2 - labelWidth/2 - 15
                checkmark.center = CGPoint(x: indicatorCenterX , y: buttonHeight/2)
            }
            checkmark.tag = UIButton.CheckMarkTag
            self.addSubview(checkmark)
        } else {
            self.imageView?.isHidden = false
            self.isEnabled = true
            if let checkmark = self.viewWithTag(UIButton.CheckMarkTag) as? UIActivityIndicatorView {
                checkmark.removeFromSuperview()
            }
        }
    }
}
