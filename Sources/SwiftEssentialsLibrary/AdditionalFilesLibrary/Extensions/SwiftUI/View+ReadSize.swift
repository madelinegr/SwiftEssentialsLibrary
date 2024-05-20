//
//  View+ReadSize.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/25.
//

import SwiftUI

public extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
  func readFrameGlobal(onChange: @escaping (CGRect) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
              .preference(key: FrameGlobalPreferenceKey.self, value: geometryProxy.frame(in: .global))
      }
    )
    .onPreferenceChange(FrameGlobalPreferenceKey.self, perform: onChange)
  }
}

private struct FrameGlobalPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
