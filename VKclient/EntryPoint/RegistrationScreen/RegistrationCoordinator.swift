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
    
    init(_ navController: UINavigationController, _ rootVC: UIViewController) {
        self.navController = navController
        self.rootVC = rootVC
    }
}
