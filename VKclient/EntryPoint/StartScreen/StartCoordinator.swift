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
        navController.navigationBar.isHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func register() {
        let registartionVC = RegistrationVC()
        let coordinator = RegistrationCoordinator(navController, registartionVC)
        let registrationPresenter = RegistrationPresenter(registartionVC, coordinator)
        registartionVC.presenter = registrationPresenter
        coordinator.start()
    }
    
    func accIsExist() {
        let loginVC = LoginVC()
        let coordinator = LoginCoordinator(navController, loginVC)
        let loginPresenter = LoginPresenter(loginVC, coordinator)
        loginVC.presenter = loginPresenter
        coordinator.start()
    }
    
     init(_ rootVC: UIViewController, _ window: UIWindow) {
        self.rootVC = rootVC
        self.navController = UINavigationController(rootViewController: rootVC)
        self.window = window
    }
    
    
}
