//
//  SliderPresentationManager.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation
import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SliderPresentationManager: NSObject {
    var direction: PresentationDirection = .right
}

extension SliderPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = SliderPresentationController(
            presentedViewController: presented,
            presenting: presenting,
            direction: direction
        )
        return presentationController
    }
}
