//
//  SwiftUIKit+Constraints.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/10.
//

import UIKit

public extension UIView {
    
    @discardableResult
    func becomeSubview<T: UIView>(of otherView: UIView) -> T {
        otherView.addSubview(self)
        return self as! T
    }
    
    @discardableResult
    func sConstraints<T: UIView>(to otherView: UIView,
                      top: Double? = nil, safeTop: Double? = nil,
                      bottom: Double? = nil, safeBottom: Double? = nil,
                      left: Double? = nil,
                      right: Double? = nil,
                      centerX: Double? = nil,
                      centerY: Double? = nil,
                      centerYSafe: Double? = nil) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        if let top {
            topAnchor.constraint(equalTo: otherView.topAnchor, constant: top).isActive = true
        }
        if let safeTop {
            topAnchor.constraint(equalTo: otherView.safeTopAnchor, constant: safeTop).isActive = true
        }
        if let bottom {
            bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: bottom).isActive = true
        }
        if let safeBottom {
            bottomAnchor.constraint(equalTo: otherView.safeBottomAnchor, constant: safeBottom).isActive = true
        }
        if let left {
            leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: left).isActive = true
        }
        if let right {
            rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: right).isActive = true
        }
        if let centerX {
            centerXAnchor.constraint(equalTo: otherView.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY {
            centerYAnchor.constraint(equalTo: otherView.centerYAnchor, constant: centerY).isActive = true
        }
        if let centerYSafe {
            centerYAnchor.constraint(equalTo: otherView.safeAreaLayoutGuide.centerYAnchor, constant: centerYSafe).isActive = true
        }
        return self as! T
    }
    
//    func sConstraintsToRootView(top: Double? = nil, safeTop: Double? = nil,
//                                bottom: Double? = nil, safeBottom: Double? = nil,
//                                left: Double? = nil, safeLeft: Double? = nil,
//                                right: Double? = nil, safeRight: Double? = nil) -> UIView {
//        translatesAutoresizingMaskIntoConstraints = false
//        if let top {
//            topAnchor.constraint(equalTo: otherView.topAnchor, constant: top).isActive = true
//        }
//        if let bottom {
//            bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: bottom).isActive = true
//        }
//        if let left {
//            leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: left).isActive = true
//        }
//        if let right {
//            rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: right).isActive = true
//        }
//        return self
//    }
    
    @discardableResult
    func sConstraints<T: UIView>(width: Double? = nil, height: Double? = nil) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return self as! T
    }
    
}
