//
//  VKProfileEditCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation
import UIKit

class VKProfileEditCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.present(rootVC, animated: true)
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileEditVC) {
        self.rootVC = rootVC
        navController = parentNC
        
    }
    
}

extension VKProfileEditCoordinator: VKProfileEditFlowDelegate {
    
    func test() {
    }
}
