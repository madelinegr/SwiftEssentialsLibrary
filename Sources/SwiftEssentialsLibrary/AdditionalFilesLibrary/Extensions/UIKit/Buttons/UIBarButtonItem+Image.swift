//
//  UIBarButtonItem+Image.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

public extension UIBarButtonItem {

    static func imageButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(frame: .init(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.becomeRound() //if creating programmaticallly, must set a width and height of the view before calling becomeRound()

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: button.frame.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: button.frame.width).isActive = true

        return menuBarItem
    }
}
