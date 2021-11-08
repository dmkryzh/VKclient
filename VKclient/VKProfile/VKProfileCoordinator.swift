//
//  VKProfileCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit
import Popover

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
    
    init(_ navi: UINavigationController, rootVC: UIViewController) {
        self.rootVC = rootVC
        navController = navi
        customiseNavBar()
    }
}

extension VKProfileCoordinator: VKProfileDelegate {
    
    func postSettingsIsChosen(_ sender: Any) {
        guard let rootVC = rootVC as? VKProfileVC else { return }
        guard let viewButton = sender as? UIButton else { return }
        let viewButtonCoverted = rootVC.view.convert(viewButton.bounds, from: viewButton)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 260))
        container.addSubview(rootVC.tableView)
        rootVC.popOver.show(container, point: CGPoint(x: viewButtonCoverted.origin.x, y: viewButtonCoverted.origin.y))
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




