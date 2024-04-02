//
//  UIView+RootSuperview.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/04.
//

import UIKit

public extension UIView {
    var rootSuperView: UIView {
        var view = self
        while let s = view.superview {
            view = s
        }
        return view
    }
    
    func firstSuperView<T: UIView>(ofType type: T.Type) -> T? {
        var currentView = self
        while let s = currentView.superview {
            if let typedView = s as? T {
                return typedView
            }
            currentView = s
        }
        return nil
    }
}
