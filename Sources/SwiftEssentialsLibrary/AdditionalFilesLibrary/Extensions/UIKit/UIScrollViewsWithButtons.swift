//
//  UIScrollViewsWithButtons.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/02.
//

import UIKit

//So that button presses do not prevent scrolling
open class UICollectionViewWithButtons: UICollectionView {
    
    public override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}

open class UITableViewWithButtons: UITableView {
    
    public override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}
