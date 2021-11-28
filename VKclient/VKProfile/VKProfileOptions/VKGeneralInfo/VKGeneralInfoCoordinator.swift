//
//  VKGeneralInfoCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation
import UIKit

class VKGeneralInfoCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func customiseNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navController.navigationBar.standardAppearance = navigationBarAppearance
        navController.navigationBar.tintColor = .black
        rootVC.navigationItem.hidesBackButton = true
    }
    
    func start() {
        navController.present(rootVC, animated: true)
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKGeneralInfoVC) {
        self.rootVC = rootVC
        navController = parentNC
    }
}

extension VKGeneralInfoCoordinator: VKGeneralInfoFlowDelegate {
    func test() {
        
    }
}

