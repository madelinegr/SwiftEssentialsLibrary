//
//  UIView+ConstrainToSuperview.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/01.
//

import UIKit

public extension UIView {
    
    func constrainToSuperview() {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
    
}
