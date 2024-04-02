//
//  SwiftUI+Modify.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/14/24.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func modify(@ViewBuilder _ transform: (Self) -> (some View)?) -> some View {
        if let view = transform(self), !(view is EmptyView) {
            view
        } else {
            self
        }
    }
    
}
//fail
//public extension ScrollView {
//    
//    @ViewBuilder
//    func modifyScrollView(@ViewBuilder _ transform: (Self) -> ScrollView?) -> ScrollView {
//        if let view = transform(self), !(view is EmptyView) {
//            view
//        } else {
//            self
//        }
//    }
//    
//}
