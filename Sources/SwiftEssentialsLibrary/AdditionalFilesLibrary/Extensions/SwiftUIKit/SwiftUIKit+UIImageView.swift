//
//  SwiftUIKit+UIImageView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/10.
//

import UIKit

public extension UIImageView {
    
    func sImage(_ image: UIImage) -> UIImageView {
        self.image = image
        return self
    }
    
    func sContentMode(_ contentMode: ContentMode) -> UIImageView {
        self.contentMode = contentMode
        return self
    }
    
}
