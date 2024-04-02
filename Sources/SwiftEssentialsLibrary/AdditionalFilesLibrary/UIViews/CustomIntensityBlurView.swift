//
//  CustomIntensityBlurView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/11/13.
//

import UIKit

class CustomIntensityBlurView: UIVisualEffectView {
    
    var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    var customIntensity: CGFloat
    
    init(effect: UIVisualEffect?, intensity: CGFloat) {
        self.customIntensity = intensity
        super.init(effect: effect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        frame = superview.bounds //Or setup constraints instead
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .dark)
        }
        animator.fractionComplete = customIntensity   //This is your blur intensity in range 0 - 1
    }
    
    deinit {
        animator.stopAnimation(true)
    }
}
