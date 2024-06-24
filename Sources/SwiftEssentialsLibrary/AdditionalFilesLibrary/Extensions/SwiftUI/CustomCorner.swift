//
//  CustomCorner.swift
//  
//
//  Created by Adam Novak on 6/24/24.
//

import SwiftUI

public struct CustomCorner: Shape {
    public var corners: UIRectCorner
    public var radius: CGFloat
    
    public init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}
