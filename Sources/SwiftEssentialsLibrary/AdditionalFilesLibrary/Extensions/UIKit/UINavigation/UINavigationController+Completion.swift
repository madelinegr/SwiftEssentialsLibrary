//
//  UINavigationController+Completion.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

extension UINavigationController {
    
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}

