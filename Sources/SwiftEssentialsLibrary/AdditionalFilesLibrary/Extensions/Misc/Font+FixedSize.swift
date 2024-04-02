//
//  Font+FixedSize.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/9/24.
//

import UIKit

extension UIApplication {
    
    //this never actually worked for me, just subclass uiapplication instead
    static let swizzleFixedAppFontSize: Void = {
        method_exchangeImplementations(
            class_getInstanceMethod(UIApplication.self, #selector(getter: fixedPreferredContentSizeCategory))!,
            class_getInstanceMethod(UIApplication.self, #selector(getter: preferredContentSizeCategory))!
        )
    }()

    @objc
    var fixedPreferredContentSizeCategory: UIContentSizeCategory {
        return .large
    }
    
}
