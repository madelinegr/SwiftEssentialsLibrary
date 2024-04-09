//
//  UIView+LoadFromNib.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation
import UIKit

public extension UIView {
    func loadViewFromNib(nibName: String, bundle: Bundle? = nil) -> UIView? {
        let bundle = bundle ?? Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
