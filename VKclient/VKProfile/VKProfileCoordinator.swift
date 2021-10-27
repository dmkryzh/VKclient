//
//  VKProfileCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit

class VKProfileCoordinator: Coordinator {
    
    var slideInTransitioningDelegate = SliderPresentationManager()
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.pushViewController(rootVC, animated: true)
    }
    
    func customiseNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navController.navigationBar.standardAppearance = navigationBarAppearance
        navController.navigationBar.tintColor = .black
        rootVC.navigationItem.hidesBackButton = true
        rootVC.navigationItem.setRightBarButton(rightButton, animated: true)
        rootVC.navigationItem.setLeftBarButton(UIBarButtonItem(), animated: false)
        rootVC.navigationItem.leftBarButtonItem?.customView = leftBarBtt
    }
    
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "text.justify")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.action = #selector(menuTapped)
        view.target = self
        return view
    }()

    let leftBarBtt: UILabel = {
        let view = UILabel()
        view.text = "default_user"
//        view.frame = CGRect(x: 0, y: 0, width: 30, height: 15)
        return view
    }()
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileVC) {
        self.rootVC = rootVC
        navController = parentNC
        customiseNavBar()
    }
    
    @objc func menuTapped() {
        let rootVC = VKProfileOptionsVC()
        let main = self.rootVC as! VKProfileVC
        rootVC.transitioningDelegate = main.sliderTransitionDelegate
        rootVC.modalPresentationStyle = .custom
        let coordinator = VKProfileOptionsCoordinator(navController, rootVC: rootVC)
        coordinator.start()
    }
    
}

extension VKProfileCoordinator: VKProfileDelegate {
    
}




