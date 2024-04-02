//
//  UIKitPreviewContainer.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/31.
//

import SwiftUI
import UIKit

public struct PreviewContainer<T: UIViewController>: UIViewControllerRepresentable {

    public let viewController: T

    public init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    public func makeUIViewController(context: Context) -> T {
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: T, context: Context) {}
}

public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    public let view: View
    
    public init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    public func makeUIView(context: Context) -> UIView {
        return view
    }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
