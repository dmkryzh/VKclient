//
//  RegistrationCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation
import UIKit

class RegistrationCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.pushViewController(rootVC, animated: true)
    }
    
    func startConfirmation() {
        let confirmationVC = ConfirmationVC()
        let coordinator = ConfirmationCoordinator(navController, confirmationVC)
        let confirmationPresenter = ConfirmationPresenter(confirmationVC, coordinator)
        confirmationVC.presenter = confirmationPresenter
        coordinator.start()
    }
    
    init(_ navController: UINavigationController, _ rootVC: UIViewController) {
        self.navController = navController
        self.rootVC = rootVC
    }
}
