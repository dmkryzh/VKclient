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

extension LoginVkCoordinator: LoginVkDelegate {
    func startFeedFlow() {
    }
    
    func startProfileFlow() {
//        let completion = { [self] in
//            let profileVK = VKProfileVC()
//            let coordinator = VKProfileCoordinator(navController, rootVC: profileVK)
//            let modelPost = VKProfileModel()
//            let modelPhoto = VKPhotoLibModel()
//            let vkPresenter = VKProfilePresenter(modelPost, modelPhotoLib: modelPhoto, profileVK, coordinator)
//            profileVK.presenter = vkPresenter
//            profileVK.dataDelegate = vkPresenter
//            coordinator.start()
//        }
//        navController.dismiss(animated: true, completion: completion)
    }
}
