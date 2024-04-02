//
//  UINavigationItem+UIButton.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

public extension UINavigationItem {
    
    func addRegularButtonAsBarButtonItem(_ button: UIButton) {
        let accountBarItem = UIBarButtonItem(customView: button)
        accountBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        accountBarItem.customView?.heightAnchor.constraint(equalToConstant: button.frame.height).isActive = true
        accountBarItem.customView?.widthAnchor.constraint(equalToConstant: button.frame.width).isActive = true
        rightBarButtonItem = accountBarItem
    }
}
