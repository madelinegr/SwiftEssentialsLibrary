//
//  UIKitPreviewContainer.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/31.
//

import SwiftUI
import UIKit

struct PreviewContainer<T: UIViewController>: UIViewControllerRepresentable {

    let viewController: T

    init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    func makeUIViewController(context: Context) -> T {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {}
}

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
