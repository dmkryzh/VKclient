//
//  VKFullPostCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 18.11.2021.
//

import Foundation
import UIKit
import Popover

class VKFullPostCoordinator: Coordinator {
    
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
//        rootVC.navigationItem.hidesBackButton = true
    }
    
    init(_ navi: UINavigationController, _ rootVC: UIViewController) {
        self.rootVC = rootVC
        navController = navi
        customiseNavBar()
    }
}

extension VKFullPostCoordinator: VKFullPostFlowDelegate {
    
    func postSettingsIsChosen() {
        
        guard let mainVC = self.rootVC as? VKFullPostVC else { return }
        let rootVC = VKFullPostSettingsVC()
        rootVC.transitioningDelegate = mainVC.sliderTransitionDelegate
        rootVC.modalPresentationStyle = .custom
        let coordinator = VKFullPostSettingsCoordinator(navController, rootVC: rootVC)
        let presenter = VKFullPostSettingsPresenter(rootVC, coordinator)
        rootVC.presenter = presenter
        coordinator.start()
    }
}

