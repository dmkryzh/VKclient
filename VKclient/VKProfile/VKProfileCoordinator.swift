//
//  VKProfileCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit

class VKProfileCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.pushViewController(rootVC, animated: true)
    }
    
    func customiseNavBar() {
        let appearance = UINavigationBarAppearance()
        navController.navigationBar.standardAppearance = appearance
    }
    
    let rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "text.justify")
        let view = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        return view
    }()
    
    init(_ parentNC: UINavigationController, rootVC: VKProfileVC) {
        self.rootVC = rootVC
        navController = parentNC
        rootVC.navigationItem.hidesBackButton = true
        rootVC.navigationItem.rightBarButtonItem = rightButton
        customiseNavBar()
    }
    
}

extension VKProfileCoordinator: VKProfileDelegate {
    
}
