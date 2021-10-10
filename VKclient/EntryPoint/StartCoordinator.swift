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
    
    var childCoordinators: [Coordinator] = []
    
    var rootVC: UIViewController
    
    var window: UIWindow?
    
    func start() {
        navController.navigationBar.isHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func registration() {
        let regVC = RegistrationVC()
        navController.pushViewController(regVC, animated: true)
    }
    
    func confirmation() {
        let confVC = ConfirmationVC()
        navController.pushViewController(confVC, animated: true)
        
    }
    
    func login() {
        let login = LoginVC()
        navController.pushViewController(login, animated: true)
    }
    
    func startProfile() {
        
    }
    
     init?(_ rootVC: UIViewController?, _ window: UIWindow?) {
        guard let vc = rootVC else { return nil }
        self.rootVC = vc
        self.navController = UINavigationController(rootViewController: vc)
        self.window = window
    }
    
    
}
