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
        feedVC.tabBarItem.image = UIImage(systemName: "scroll")
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
        let secondVC = VKCollectionVC()
        secondVC.tabBarItem.title = "Collection"
        secondVC.tabBarItem.image = UIImage(systemName: "eye")
        let secondNavi = UINavigationController()
        let colCoordinator = VKCollectionCoordinator(secondNavi, rootVC: secondVC)
        let colModel = VKProfileModel()
        let colPresenter = VKCollectionPresenter(colModel, secondVC, colCoordinator)
        secondVC.dataDelegate = colPresenter
        secondVC.presenter = colPresenter
        colCoordinator.start()
        return secondNavi
    }
    
    func configureLeftTestTabBtnn() -> UINavigationController {
        let view = UIViewController()
        view.view.backgroundColor = .green
        view.tabBarItem.title = "TestLeft"
        view.tabBarItem.image = UIImage(systemName: "circle.grid.cross.left.filled")
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    func configureRightTestTabBtnn() -> UINavigationController {
        let view = UIViewController()
        view.view.backgroundColor = .yellow
        view.tabBarItem.title = "TestRight"
        view.tabBarItem.image = UIImage(systemName: "circle.grid.cross.right.filled")
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    func configureTabBarVCs() {
        guard let tabBar = rootVC as? TabBarMain else { return }
        tabBar.viewControllers = [configureFeedTabBtnn(), configureLeftTestTabBtnn(), configureProfileTabBtnn(), configureRightTestTabBtnn(), configureSavedPosts()]
        tabBar.selectedIndex = 2
    }
}

    
