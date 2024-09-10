//
//  UIVC+InteractivePop.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {

    public func disableInteractivePopGesture() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }

    //this was working at some point, but it's not consistently working for me anymore.
    public func enableInteractivePopGesture() {
        navigationItem.hidesBackButton = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        navigationController?.interactivePopGestureRecognizer?.delegate = nil //only works when doing this
  }
    
}
