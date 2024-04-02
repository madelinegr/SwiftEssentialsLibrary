//
//  GraidentView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/02.
//

import UIKit

enum GradientDirection {
    case topToBottom
    case leftToRight
}

class GradientView: UIView {
    var gradientLayer: CAGradientLayer!

    init(direction: GradientDirection, firstColor: UIColor, firstAlpha: CGFloat, secondColor: UIColor, secondAlpha: CGFloat) {
        super.init(frame: .zero)
        self.createGradientLayer(direction: direction, firstColor: firstColor, firstAlpha: firstAlpha, secondColor: secondColor, secondAlpha: secondAlpha)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createGradientLayer(direction: .topToBottom, firstColor: .black, firstAlpha: 1, secondColor: .white, secondAlpha: 1)
    }
    
    func createGradientLayer(direction: GradientDirection, firstColor: UIColor, firstAlpha: CGFloat, secondColor: UIColor, secondAlpha: CGFloat) {
        gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.bounds
        gradientLayer.colors = [firstColor.withAlphaComponent(firstAlpha).cgColor, secondColor.withAlphaComponent(secondAlpha).cgColor]
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
