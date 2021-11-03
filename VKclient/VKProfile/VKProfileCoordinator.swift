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
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileVC) {
        self.rootVC = rootVC
        navController = parentNC
        customiseNavBar()
    }
    
}

extension VKProfileCoordinator: VKProfileDelegate {
    
    func postSettingsIsChosen() {
       
    }

    func settingsFlowIsChosen() {
        guard let mainVC = self.rootVC as? VKProfileVC else { return }
        let rootVC = VKProfileOptionsVC()
        rootVC.transitioningDelegate = mainVC.sliderTransitionDelegate
        rootVC.modalPresentationStyle = .custom
        let coordinator = VKProfileOptionsCoordinator(navController, rootVC: rootVC)
        coordinator.start()
    }
    
    
}




