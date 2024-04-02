//
//  UIVC+InteractivePop.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {

  func disableInteractivePopGesture() {
    navigationItem.hidesBackButton = true
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }

  func enableInteractivePopGesture() {
    navigationItem.hidesBackButton = false
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
    
}
