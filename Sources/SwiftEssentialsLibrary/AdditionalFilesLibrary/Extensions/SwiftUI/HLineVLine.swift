//
//  File.swift
//  
//
//  Created by Adam Novak on 5/21/24.
//

import SwiftUI

//https://stackoverflow.com/questions/58526632/swiftui-create-a-single-dashed-line-with-swiftui

public struct VLine: Shape {
    
    public init() {
        
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

public struct HLine: Shape {
    
    public init() {
        
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}

//use like this:
//struct ContentView: View {
//     var body: some View {
//         HLine()
//           .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//           .frame(height: 1)
//    }
//}
