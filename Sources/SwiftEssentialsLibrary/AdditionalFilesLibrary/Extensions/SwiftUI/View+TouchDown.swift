//
//  View+TouchDown.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/26.
//

import SwiftUI

extension View {
    func onTouchDownGesture(onTapDown: @escaping () -> Void = {}, onTapUp: @escaping () -> Void = {}) -> some View {
        modifier(OnTouchDownGestureModifier(onTapDown: onTapDown, onTapUp: onTapUp))
    }
}

///NOTE: Blocks scroll view functionality
private struct OnTouchDownGestureModifier: ViewModifier {
//    @Binding var tapped: Bool //wasnt working
    var onTapDown: () -> Void = {}
    var onTapUp: () -> Void = {}

    func body(content: Content) -> some View {
        content
            //not tested
//            .onLongPressGesture(minimumDuration: 0, perform: {}) { pressing in
//                tapped = pressing
//            }
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
//                    self.tapped = true
                    self.onTapDown()
                }
                .onEnded { _ in
//                    self.tapped = false
                    self.onTapUp()
                })
    }
}
