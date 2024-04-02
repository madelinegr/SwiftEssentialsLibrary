//
//  PhotoCaptureProcessor.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/20.
//

import AVFoundation
import Photos

open class PhotoCaptureProcessor: NSObject {
    public var requestedPhotoSettings: AVCapturePhotoSettings
    
    public let willCapturePhotoAnimation: () -> Void
        
    public lazy var context = CIContext()
    
    public let completionHandler: (PhotoCaptureProcessor) -> Void
    
    public let photoProcessingHandler: (Bool) -> Void
    
    public var photo: AVCapturePhoto?
        
    public var portraitEffectsMatteData: Data?
    
    public var maxPhotoProcessingTime: CMTime?

    // Save the location of captured photos
    public var location: CLLocation?

    public init(with requestedPhotoSettings: AVCapturePhotoSettings,
         willCapturePhotoAnimation: @escaping () -> Void,
         livePhotoCaptureHandler: @escaping (Bool) -> Void,
         completionHandler: @escaping (PhotoCaptureProcessor) -> Void,
         photoProcessingHandler: @escaping (Bool) -> Void) {
        self.requestedPhotoSettings = requestedPhotoSettings
        self.willCapturePhotoAnimation = willCapturePhotoAnimation
        self.completionHandler = completionHandler
        self.photoProcessingHandler = photoProcessingHandler
    }
    
    private func didFinish() {
        completionHandler(self)
    }
}


extension PhotoCaptureProcessor: AVCapturePhotoCaptureDelegate {
    
    /// - Tag: WillBeginCapture
    public func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("time range", resolvedSettings.photoProcessingTimeRange)
        maxPhotoProcessingTime = resolvedSettings.photoProcessingTimeRange.start + resolvedSettings.photoProcessingTimeRange.duration
    }
    
    /// - Tag: WillCapturePhoto
    public func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
        willCapturePhotoAnimation()
    
        guard let maxPhotoProcessingTime = maxPhotoProcessingTime else {
            return
        }
        
//        toggleTorch(true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.toggleTorch(false)
//        }
        
        // Show a spinner if processing time exceeds one second.
        let oneSecond = CMTime(seconds: 1, preferredTimescale: 1)
        if maxPhotoProcessingTime > oneSecond {
            photoProcessingHandler(true)
        }
    }
    
    /// - Tag: DidFinishProcessingPhoto
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        photoProcessingHandler(false)
        
        if let error = error {
            print("Error didFinishProcessing: \(error)")
            return
        } else {
            self.photo = photo
        }
        
        print("ORIENTATION", photo.metadata[kCGImagePropertyOrientation as String])
        
    }

    
    /// - Tag: DidFinishCapture
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        guard error == nil, let photo = photo else {
            print("Error didFinishCapture: \(error!)")
            didFinish()
            return
        }
                
        save(photo: photo)
        //upload photo to remote server
    }
    
    public func save(photo: AVCapturePhoto) {
        guard PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized || PHPhotoLibrary.authorizationStatus(for: .readWrite) == .limited else {
            print("User never granted access to save photos")
            didFinish()
            return
        }
        
        guard let photoData = photo.fileDataRepresentation()  else {
            print("Can't extract photo data")
            didFinish()
            return
        }

        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.forAsset()
            let options = PHAssetResourceCreationOptions()
//            options.uniformTypeIdentifier = self.requestedPhotoSettings.processedFileType.map { $0.rawValue }
            creationRequest.addResource(with: .photo, data: photoData, options: options)
            
//            creationRequest.location = LocationManager.shared.lastLocation
            creationRequest.creationDate = Date()
        }, completionHandler: { _, error in
            if let error = error {
                print("Error occurred while saving photo to photo library: \(error)")
            }
            
            self.didFinish()
        })
    }
}
