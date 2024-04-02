//
//  UIImageView+ProfilePic.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UIImageView {
    
    func becomeProfilePicImageView(with profilePic: UIImage?) {
        image = profilePic
        contentMode = .scaleAspectFill
        becomeRound()
        if let buttonSuperview = superview as? UIButton {
            buttonSuperview.setImage(profilePic, for: .normal) //the old button type requires this method of setting the image
//            buttonSuperview.becomeRound() //this causes undesired behavior in certain cases. other subviews of the button, like a badgeview, get clipped, too. we only want to clip the image view, though
        }
    }
    
}
