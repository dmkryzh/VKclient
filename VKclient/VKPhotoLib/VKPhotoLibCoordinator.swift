//
//  VKPhotoLibCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.10.2021.
//

import Foundation
import UIKit
import Popover

class VKPhotoLibCoordinator: Coordinator {
    
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
    }
    
    init(_ navi: UINavigationController, _ rootVC: UIViewController) {
        self.rootVC = rootVC
        navController = navi
        customiseNavBar()
    }
}

extension VKPhotoLibCoordinator: VKPhotoLibFlowDelegate {
    func navigateToSomewhere() {
    
    }

}
