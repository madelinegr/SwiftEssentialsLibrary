//
//  CGPoint+Hashable.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/07.
//

import CoreGraphics
import Foundation

extension CGPoint : Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}
