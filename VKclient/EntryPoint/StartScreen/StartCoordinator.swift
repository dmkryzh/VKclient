//
//  StartCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

class StartCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    var window: UIWindow?
    
    func start() {
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.tintColor = .black
        navController.navigationBar.backgroundColor = .clear
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    init(_ rootVC: UIViewController, _ window: UIWindow) {
        self.rootVC = rootVC
        self.navController = UINavigationController(rootViewController: rootVC)
        self.window = window
    }
}

extension StartCoordinator: StartDelegate {
    
    func registrationFlowChosen() {
        let registartionVC = RegistrationVC()
        let coordinator = RegistrationCoordinator(navController, registartionVC)
        let registrationPresenter = RegistrationPresenter(registartionVC, coordinator)
        registartionVC.presenter = registrationPresenter
        coordinator.start()
    }
    
    func loginFlowChosen() {
        let loginVC = LoginVC()
        let coordinator = LoginCoordinator(navController, loginVC)
        let loginPresenter = LoginPresenter(loginVC, coordinator)
        loginVC.presenter = loginPresenter
        coordinator.start()
    }
    
}
