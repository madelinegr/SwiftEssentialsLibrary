//
//  UIView+BecomeUIImage.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/09.
//

import UIKit
import QuartzCore
//#import <QuartzCore/QuartzCore.h>


public extension UIView {
    
    func asUIImage(frame: CGSize? = nil, bounds: CGSize? = nil) -> UIImage? {
        //creates new image context with same size as view
//        UIGraphicsBeginImageContextWithOptions(scale=0.0) // for high res capture        
        if let frame {
            UIGraphicsBeginImageContextWithOptions(frame, true, 0.0)
        } else if let bounds {
            UIGraphicsBeginImageContextWithOptions(bounds, true, 0.0)
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        }
        // renders the view's layer into the current graphics context
        if let context = UIGraphicsGetCurrentContext() { self.layer.render(in: context) }

        // creates UIImage from what was drawn into graphics context
        let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        // clean up newly created context and return screenshot
        UIGraphicsEndImageContext()
        return screenshot
    }
    
    //The neweset approach, which works but doesnt give a CGImage underneath
    func asUIImageSnapshot() -> UIImage {
        let fmt = UIGraphicsImageRendererFormat() //not sure what the "scale" actually does
        fmt.scale = 1
        let renderer = UIGraphicsImageRenderer(size: .init(width: self.bounds.width, height: self.bounds.height), format: fmt)
        return renderer.image { _ in
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
    
    func asUIImageDrawn() -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.cgImage!)
    }


    
}
