//
//  VKProfileOptionsCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation
import UIKit

class VKProfileOptionsCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
//        let transition = SliderPresentationManager()
//        rootVC.transitioningDelegate = transition
//        rootVC.modalPresentationStyle = .custom
        navController.present(rootVC, animated: true)
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileOptionsVC) {
        self.rootVC = rootVC
        navController = parentNC
        
    }
    
}
