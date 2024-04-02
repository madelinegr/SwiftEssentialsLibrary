//
//  UIViewController+ClassName.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIViewController {
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
