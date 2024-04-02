//
//  TapUISlider.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/22.
//

import UIKit

class TapUISlider: UISlider {
    
    var trackRectWidth: CGFloat = 10
    var thumbRectHorizontalOffset: CGFloat = 0
    
     private var thumbFrame: CGRect {
         return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
     }


    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        var newRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        newRect.origin.y = thumbRectHorizontalOffset
        return newRect
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
       var newBounds = super.trackRect(forBounds: bounds)
       newBounds.size.height = trackRectWidth
       return newBounds
    }
    
    @objc
    private func sliderTapped(touch: UITouch) {
        let point = touch.location(in: self)
        let percentage = Float(point.x / self.bounds.width)
        let delta = percentage * (self.maximumValue - self.minimumValue)
        let newValue = self.minimumValue + delta
        if newValue != self.value {
            value = newValue
            sendActions(for: .valueChanged)
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        sliderTapped(touch: touch)
        return true
    }
    
}

class TallerUISlider: UISlider {
    
    var trackRectWidth: CGFloat = 10
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
       var newBounds = super.trackRect(forBounds: bounds)
       newBounds.size.height = trackRectWidth
       return newBounds
    }
    
}

