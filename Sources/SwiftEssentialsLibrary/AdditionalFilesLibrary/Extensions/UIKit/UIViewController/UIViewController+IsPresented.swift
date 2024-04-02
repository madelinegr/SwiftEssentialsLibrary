//
//  UIViewController+IsPresented.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/10/19.
//

import UIKit

extension UIViewController {
    var isPresented: Bool {
        if let navigationController = self.navigationController {
            return navigationController.viewControllers.first != self || presentingViewController != nil
        } else {
            return presentingViewController != nil
        }
    }
}
