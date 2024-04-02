//
//  ButtonNotInterruptingScrollViews.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/13.
//

import UIKit

//So that button presses do not prevent scrolling
class ButtonNotInterruptingCollectionView: UICollectionView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}

class ButtonNotInterruptingTableView: UITableView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}
