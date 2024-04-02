//
//  UIScrollView+IsAt.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIScrollView {

//    var isAtOrAboveTopAmount: Double {
//        return contentOffset.y <= verticalOffsetForTop
//    }
    
    var isAtTop: Bool {
        print(contentOffset.y, verticalOffsetForTop)
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }

}
