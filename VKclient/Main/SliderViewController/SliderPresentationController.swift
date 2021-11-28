//
//  SliderPresentationController.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation
import UIKit
import SnapKit

class SliderPresentationController: UIPresentationController {
    
    private lazy var dimmingView: UIView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0.0
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    private var direction: PresentationDirection
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    @objc func handleTap() {
        presentingViewController.dismiss(animated: true)
    }
    
    override func presentationTransitionWillBegin() {
        
        guard let containerView = containerView else { return }
        
        containerView.insertSubview(dimmingView, at: 0)
        
        dimmingView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() { 
        super.dismissalTransitionWillBegin()
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
          }

          coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
          })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        switch direction {
          case .left, .right:
            return CGSize(width: parentSize.width * (3.0 / 4.0), height: parentSize.height)
          case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height * (1.0 / 4.0))
          }
        
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
          frame.size = size(forChildContentContainer: presentedViewController,
                            withParentContainerSize: containerView!.bounds.size)

          switch direction {
          case .right:
            frame.origin.x = containerView!.frame.width*(1.0/4.0)
          case .bottom:
              frame.origin.y = containerView!.frame.height*(3.0/4.0)
          default:
            frame.origin = .zero
          }
          return frame
    }
    
}

