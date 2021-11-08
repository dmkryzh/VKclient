//
//  TabBarMainCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 08.11.2021.
//

import Foundation
import UIKit

class TabBarMainCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    func start() {
        configureTabBarVCs()
        navController.pushViewController(rootVC, animated: true)
    }
    
    init(_ rootVC: UITabBarController, _ navi: UINavigationController) {
        self.rootVC = rootVC
        navController = navi
    }
}

extension TabBarMainCoordinator: TabBarMainDelegate {
    
    func profileFlowIsChosen() {
        guard let tabBar = rootVC as? TabBarMain else { return }
        tabBar.selectedIndex = 1
    }
    
    
    func configureTabBarVCs() {

        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .yellow
        firstVC.tabBarItem.title = "Favorite"
        firstVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        let firstNavi = UINavigationController(rootViewController: firstVC)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .green
        secondVC.tabBarItem.title = "Feed"
        secondVC.tabBarItem.image = UIImage(systemName: "mic.fill")
        let secondNavi = UINavigationController(rootViewController: secondVC)
        
        let middleVC = VKProfileVC()
        let middleNavi = UINavigationController()
        let middleCoordinator = VKProfileCoordinator(middleNavi, rootVC: middleVC)
        let modelPost = VKProfileModel()
        let modelPhoto = VKPhotoLibModel()
        let vkPresenter = VKProfilePresenter(modelPost, modelPhotoLib: modelPhoto, middleVC, middleCoordinator)
        middleVC.dataDelegate = vkPresenter
        middleVC.delegate = vkPresenter
        middleCoordinator.start()
        
        guard let tabBar = rootVC as? TabBarMain else { return }
        tabBar.viewControllers = [firstNavi, middleNavi, secondNavi]
        tabBar.selectedIndex = 1
        
    }
}

    
