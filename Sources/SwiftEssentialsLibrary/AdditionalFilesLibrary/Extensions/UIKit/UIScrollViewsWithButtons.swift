//
//  UIScrollViewsWithButtons.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/02.
//

import UIKit

//So that button presses do not prevent scrolling
class UICollectionViewWithButtons: UICollectionView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}

class UITableViewWithButtons: UITableView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}
