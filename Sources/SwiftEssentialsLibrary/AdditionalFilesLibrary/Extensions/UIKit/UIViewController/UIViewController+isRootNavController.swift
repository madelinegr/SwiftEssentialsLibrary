//
//  UIViewController+isRootNavController.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 1/31/24.
//

import UIKit

extension UIViewController {
    
    var isRootNavController: Bool {
        navigationController?.viewControllers.first == self
    }
    
}
