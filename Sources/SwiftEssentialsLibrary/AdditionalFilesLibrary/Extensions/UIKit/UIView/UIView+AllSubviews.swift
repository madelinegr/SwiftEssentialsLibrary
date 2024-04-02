//
//  UIView+AllSubviews.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/08.
//

import UIKit

public extension UIView {
    
    ///Includes self
    var allSubviews: [UIView] {
        var all = [UIView]()
        func getSubview(view: UIView) {
            all.append(view)
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
}
