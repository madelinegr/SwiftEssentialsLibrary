//
//  UIViewController+DismissFlag.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIViewController {
    var isAboutToClose: Bool {
        return self.isBeingDismissed ||
               self.isMovingFromParent ||
               self.navigationController?.isBeingDismissed ?? false
    }
}
