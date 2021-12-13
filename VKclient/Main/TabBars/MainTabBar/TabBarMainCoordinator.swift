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
        
        navController.pushViewController(rootVC, animated: true)
        configureTabBarVCs()
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
    
    func configureProfileTabBtnn() -> UINavigationController {
        let middleVC = VKProfileVC()
        middleVC.tabBarItem.title = "Profile"
        middleVC.tabBarItem.image = UIImage()
        // temporary workaround
        if UIDevice.current.userInterfaceIdiom == .pad {
        middleVC.tabBarItem.titlePositionAdjustment.vertical = 15
        middleVC.tabBarItem.titlePositionAdjustment.horizontal = 7
        }
        
        let middleNavi = UINavigationController()
        let middleCoordinator = VKProfileCoordinator(middleNavi, rootVC: middleVC)
        let modelPost = VKProfileModel()
        let modelPhoto = VKPhotoLibModel()
        let vkPresenter = VKProfilePresenter(modelPost, modelPhoto, middleVC, middleCoordinator)
        middleVC.dataDelegate = vkPresenter
        middleVC.presenter = vkPresenter
        middleCoordinator.start()
        return middleNavi
    }
    
    func configureFeedTabBtnn() -> UINavigationController {
        let feedVC = VKFeedVC()
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "house.fill")
        let feedNavi = UINavigationController()
        let feedCoordinator = VKFeedCoordinator(feedNavi, feedVC)
        let modelPost = VKProfileModel()
        let modelStory = VKPhotoLibModel()
        let feedPresenter = VKFeedPresenter(modelPost, modelStory, feedVC, feedCoordinator)
        feedVC.dataDelegate = feedPresenter
        feedVC.presenter = feedPresenter
        feedCoordinator.start()
        return feedNavi
    }
    
    func configureSavedPosts() -> UINavigationController {
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .green
        secondVC.tabBarItem.title = "Collection"
        secondVC.tabBarItem.image = UIImage(systemName: "mic.fill")
        let secondNavi = UINavigationController(rootViewController: secondVC)
        return secondNavi
    }
    
    func configureTabBarVCs() {
        guard let tabBar = rootVC as? TabBarMain else { return }
        tabBar.viewControllers = [configureFeedTabBtnn(), configureProfileTabBtnn(), configureSavedPosts()]
        tabBar.selectedIndex = 1
    }
}

    
