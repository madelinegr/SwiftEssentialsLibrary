//
//  UITableView+AnimateReload.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UITableView {
    
    func reloadDataWithRowAnimation(_ animation: UITableView.RowAnimation) {
        // First, update the table view's data without animation
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
    
    func reloadDataWithViewAnimation(_ animation: UIView.AnimationOptions, duration: Double) {
        UIView.transition(with: self, duration: duration, options: animation, animations: {
            self.reloadData()
        }, completion: nil)
    }
    
}
