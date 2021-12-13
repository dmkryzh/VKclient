//
//  VKFullPostSettingsCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation
import UIKit

class VKFullPostSettingsCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.present(rootVC, animated: true)
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKFullPostSettingsVC) {
        self.rootVC = rootVC
        navController = parentNC

    }
}

extension VKFullPostSettingsCoordinator: VKFullPostSettingsFlowDelegate {
    
    func test() {
        print("test")
    }
}

