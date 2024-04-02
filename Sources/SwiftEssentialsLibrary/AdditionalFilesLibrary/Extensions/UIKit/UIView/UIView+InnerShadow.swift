//
//  UIView+InnerShadow.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/24/24.
//

import UIKit

extension UIView {
    
    ///I believe this should really be called everytime on layoutSubviews() if the view moves around for it to always be positioned properly
    func addInnerShadow(opacity: Float, radius: Double, color: UIColor, width: Double, height: Double) {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        // Shadow path (1pt ring around bounds)
        let path = UIBezierPath(rect: innerShadow.bounds.insetBy(dx: width, dy: height))
        let cutout = UIBezierPath(rect: innerShadow.bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = color.cgColor
        innerShadow.shadowOffset = CGSize.zero
        innerShadow.shadowOpacity = opacity
        innerShadow.shadowRadius = radius
        // Add
        layer.addSublayer(innerShadow)
    }
    
}

//this works best
public class EdgeShadowLayer: CAGradientLayer {

    public enum Edge {
        case Top
        case Left
        case Bottom
        case Right
    }

    public init(forView view: UIView,
                edge: Edge = Edge.Top,
                shadowRadius radius: CGFloat = 20.0,
                shadowInset inset: CGFloat = 0,
                toColor: UIColor = UIColor.white,
                fromColor: UIColor = UIColor.black) {
        super.init()
        self.colors = [fromColor.cgColor, toColor.cgColor]
        self.shadowRadius = radius

        let viewFrame = view.frame

        switch edge {
            case .Top:
                startPoint = CGPoint(x: 0.5, y: 0.0)
                endPoint = CGPoint(x: 0.5, y: 1.0)
                self.frame = CGRect(x: 0.0, y: inset, width: viewFrame.width, height: shadowRadius)
            case .Bottom:
                startPoint = CGPoint(x: 0.5, y: 1.0)
                endPoint = CGPoint(x: 0.5, y: 0.0)
                self.frame = CGRect(x: 0.0, y: viewFrame.height - shadowRadius - inset, width: viewFrame.width, height: shadowRadius)
            case .Left:
                startPoint = CGPoint(x: 0.0, y: 0.5)
                endPoint = CGPoint(x: 1.0, y: 0.5)
                self.frame = CGRect(x: inset, y: 0.0, width: shadowRadius, height: viewFrame.height)
            case .Right:
                startPoint = CGPoint(x: 1.0, y: 0.5)
                endPoint = CGPoint(x: 0.0, y: 0.5)
                self.frame = CGRect(x: viewFrame.width - shadowRadius - inset, y: 0.0, width: shadowRadius, height: viewFrame.height)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
