//
//  LoginVkCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation
import UIKit

class LoginVkCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.present(rootVC, animated: true)
    }
    
    init(_ nav: UINavigationController, _ vc: UIViewController) {
        navController = nav
        rootVC = vc
    }
}

extension LoginVkCoordinator: LoginVkPresenterDelegate {
    
    func test() {
        
    }
    
    func startProfileFlow() {
        let completion = { [self] in
            let tabBar = TabBarMain()
            let tabBarCoordinator = TabBarMainCoordinator(tabBar, navController)
            let tabBarPresenter = TabBarPresenter(tabBar, tabBarCoordinator)
            tabBar.tapDelegate = tabBarPresenter
            tabBarCoordinator.start()
            navController.isNavigationBarHidden = true
        }
        
        navController.dismiss(animated: true, completion: completion)
    }
}
