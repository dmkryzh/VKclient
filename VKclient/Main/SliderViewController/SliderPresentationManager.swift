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
    var disableCompactHeight = false
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
    
    func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController,
      source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return SliderPresentationAnimation(direction: direction, isPresentation: true)
    }

    func animationController(
      forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return SliderPresentationAnimation(direction: direction, isPresentation: false)
    }

}

extension SliderPresentationManager: UIAdaptivePresentationControllerDelegate {
  func adaptivePresentationStyle(
    for controller: UIPresentationController,
    traitCollection: UITraitCollection
  ) -> UIModalPresentationStyle {
    if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
      return .overFullScreen
    } else {
      return .none
    }
  }
}


