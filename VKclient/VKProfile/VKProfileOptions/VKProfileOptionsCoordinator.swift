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
        navController.present(rootVC, animated: true)
    }
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileOptionsVC) {
        self.rootVC = rootVC
        navController = parentNC
        
    }
    
}

extension VKProfileOptionsCoordinator: VKProfileOptionsFlowDelegate {
    
    func generalInfoIsChosen() {
        
        navController.dismiss(animated: true, completion: nil)
        let infoVC = VKGeneralInfoVC()
        let coordinator = VKGeneralInfoCoordinator(navController, rootVC: infoVC)
        let infoPresenter = VKGeneralInfoPresenter(infoVC, coordinator)
        infoVC.presenter = infoPresenter
        infoVC.modalPresentationStyle = .fullScreen
        coordinator.start()
    }
}

