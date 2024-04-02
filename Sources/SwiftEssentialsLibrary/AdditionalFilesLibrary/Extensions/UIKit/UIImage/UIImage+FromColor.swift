//
//  UIImage+FromColor.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIImage {
    
    ///corner radius not working yet
    class func imageFromColor(color: UIColor, cornerRadius: Double? = nil) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        
        if let cornerRadius {
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        }
//        draw(in: rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
//    public func rounded(radius: CGFloat) -> UIImage {
//        let rect = CGRect(origin: .zero, size: size)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
//        draw(in: rect)
//        return UIGraphicsGetImageFromCurrentImageContext()!
//    }
    
    class func radialGradientImage(size: CGSize, radialColor: UIColor, bgColor: UIColor, centre: CGPoint, radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 1)

        var red1: CGFloat = 0.0, green1: CGFloat = 0.0, blue1: CGFloat = 0.0, alpha1: CGFloat = 0.0
        radialColor.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)

        var red2: CGFloat = 0.0, green2: CGFloat = 0.0, blue2: CGFloat = 0.0, alpha2: CGFloat = 0.0
        bgColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let components: [CGFloat] = [
            red1, green1, blue1, alpha1,
            red2, green2, blue2, alpha2
        ]

        if let myColorspace = CGColorSpace(name: CGColorSpace.genericRGBLinear) {
            let myGradient = CGGradient(colorSpace: myColorspace,
                                        colorComponents: components, locations: locations,
                                        count: locations.count)

            let myCentrePoint = CGPoint(x: centre.x * size.width, y: centre.y * size.height)
            let myRadius = min(size.width, size.height) * radius

            if let context = UIGraphicsGetCurrentContext(), let gradient = myGradient {
                context.drawRadialGradient(gradient,
                                           startCenter: myCentrePoint,
                                           startRadius: 0,
                                           endCenter: myCentrePoint,
                                           endRadius: myRadius,
                                           options: .drawsAfterEndLocation)
            }

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        else {
            return nil
        }
    }
    
}

//these extensions work strangely with width and height sometimes
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
