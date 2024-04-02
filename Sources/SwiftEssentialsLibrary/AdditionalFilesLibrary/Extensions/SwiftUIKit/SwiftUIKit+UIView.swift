//
//  SwiftUIKit+UIView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/10.
//

import UIKit

extension UIView {
    
    convenience public init(bgColor: UIColor? = nil, border: UIViewBorder? = nil) {
        self.init()
        backgroundColor = bgColor
        if let border {
            layer.cornerCurve = border.cornerCurve
            layer.cornerRadius = border.cornerRadius
            layer.borderWidth = border.thickness
            layer.borderColor = border.borderColor.cgColor
        }
    }
    
}

public extension UIView {
    
    struct UIViewBorder {
        var cornerRadius: CGFloat = 0
        var cornerCurve: CALayerCornerCurve = .continuous
        var borderColor: UIColor = .clear
        var thickness: CGFloat = 0
        
        public init(cornerRadius: CGFloat = 0, cornerCurve: CALayerCornerCurve = .continuous, borderColor: UIColor = .clear, thickness: CGFloat = 0) {
            self.cornerRadius = cornerRadius
            self.cornerCurve = cornerCurve
            self.borderColor = borderColor
            self.thickness = thickness
        }
    }
    
    @discardableResult
    func sBorder<T: UIView>(_ border: UIViewBorder) -> T {
        layer.cornerCurve = border.cornerCurve
        layer.cornerRadius = border.cornerRadius
        layer.borderWidth = border.thickness
        layer.borderColor = border.borderColor.cgColor
        return self as! T
    }

    @discardableResult
    func sIsHidden<T: UIView>(_ isHidden: Bool) -> T {
        self.isHidden = isHidden
        return self as! T
    }

    @discardableResult
    func sAlpha<T: UIView>(_ alpha: Double) -> T {
        self.alpha = CGFloat(alpha)
        return self as! T
    }
    
    @discardableResult
    func sMasksToBounds<T: UIView>(_ masksToBounds: Bool) -> T {
        self.layer.masksToBounds = masksToBounds
        return self as! T
    }

    @discardableResult
    func sZPosition<T: UIView>(_ zPosition: CGFloat) -> T {
        self.layer.zPosition = zPosition
        return self as! T
    }

    @discardableResult
    func sBackgroundColor<T: UIView>(_ backgroundColor: UIColor) -> T {
        self.backgroundColor = backgroundColor
        return self as! T
    }

    @discardableResult
    func sTintColor<T: UIView>(_ tintColor: UIColor) -> T {
        self.tintColor = tintColor
        return self as! T
    }

    @discardableResult
    func sTransform<T: UIView>(_ transform: CGAffineTransform) -> T {
        self.transform = transform
        return self as! T
    }
    
    @discardableResult
    func sTag<T: UIView>(_ tag: Int) -> T {
        self.tag = tag
        return self as! T
    }

    @discardableResult
    func sFrame<T: UIView>(_ frame: CGRect) -> T {
        self.frame = frame
        return self as! T
    }
    
    @discardableResult
    func sGestureRecognizer<T: UIView>(_ gestureRecognizer: UIGestureRecognizer) -> T {
        self.addGestureRecognizer(gestureRecognizer)
        return self as! T
    }

}
