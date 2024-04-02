//
//  UIImage+Blur.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIImage {
        
    func blur() -> UIImage {
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: self)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(120, forKey: kCIInputRadiusKey)

        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let output = cropFilter!.outputImage
        let cgimg = CIContext(options: nil).createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }

}
