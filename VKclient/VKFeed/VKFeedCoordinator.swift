//
//  VKFeedCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.11.2021.
//

import Foundation
import UIKit
import Popover
import SnapKit

class VKFeedCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        navController.pushViewController(rootVC, animated: true)
    }
    
    func customiseNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navController.navigationBar.standardAppearance = navigationBarAppearance
        navController.navigationBar.tintColor = .black
        rootVC.navigationItem.hidesBackButton = true
    }
    
    init(_ navi: UINavigationController, _ rootVC: UIViewController) {
        self.rootVC = rootVC
        navController = navi
        customiseNavBar()
    }
}

extension VKFeedCoordinator: VKFeedFlowDelegate {
    
    func friendProfileIsChosen() {
        let profileVK = VKProfileVC()
        let coordinator = VKProfileCoordinator(navController, rootVC: profileVK)
        let modelPost = VKProfileModel()
        let modelPhoto = VKPhotoLibModel()
        let vkPresenter = VKProfilePresenter(modelPost, modelPhoto, profileVK, coordinator)
        profileVK.dataDelegate = vkPresenter
        profileVK.presenter = vkPresenter
        profileVK.friendProfile()
        coordinator.start()
    }
    
    
    func testScanIsChosen() {
        let vc = VKToolsVC()
        let coordinator = VKToolsCoordinator(navController, vc)
        let presenter = VKToolsPresenter(vc, coordinator)
        vc.presenter = presenter
        coordinator.start()
    }
    
    
    func settingsFlowIsChosen() {
        let vc = VKToolsVC()
        let coordinator = VKToolsCoordinator(navController, vc)
        let presenter = VKToolsPresenter(vc, coordinator)
        vc.presenter = presenter
        coordinator.start()
    }
    
    func postSettingsIsChosen(_ sender: Any) {
        guard let rootVC = rootVC as? VKFeedVC else { return }
        guard let viewButton = sender as? UIButton else { return }
        let viewButtonConverted = rootVC.view.convert(viewButton.bounds, from: viewButton)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 260))
        container.addSubview(rootVC.tableView)
        rootVC.popOver.show(container, point: CGPoint(x: viewButtonConverted.origin.x, y: viewButtonConverted.origin.y))
    }
    
}
