//
//  StartCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

class StartCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var rootVC: UIViewController
    
    var window: UIWindow?
    
    func start() {
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func configureNavBar() {
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.setBackIndicatorImage(UIImage(named: "backButton"), transitionMaskImage: UIImage(named: "backButton"))
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.configureWithTransparentBackground()
        
        navController.navigationBar.standardAppearance = navigationBarAppearance
        navController.navigationBar.standardAppearance.buttonAppearance = barButtonItemAppearance
        navController.navigationBar.tintColor = .black
        
    }
    
    init(_ rootVC: UIViewController, _ window: UIWindow) {
        
        self.rootVC = rootVC
        self.navController = UINavigationController(rootViewController: rootVC)
        self.configureNavBar()
        self.window = window
    }
}

extension StartCoordinator: StartFlowDelegate {
    
    func fakeRegistrationFlowChosen() {
        let registartionVC = RegistrationVC()
        let coordinator = RegistrationCoordinator(navController, registartionVC)
        let registrationPresenter = RegistrationPresenter(registartionVC, coordinator)
        registartionVC.presenter = registrationPresenter
        coordinator.start()
    }
    
    func registrationFlowChosen() {
        let loginVk = LoginVkVC()
        let coordinator = LoginVkCoordinator(navController, loginVk)
        let model = LoginVkModel()
        let vkPresenter = LoginVkPresenter(model, loginVk, coordinator)
        loginVk.delegate = vkPresenter
        coordinator.start()
    }
    
    func loginFlowChosen() {
        let loginVC = LoginVC()
        let coordinator = LoginCoordinator(navController, loginVC)
        let loginPresenter = LoginPresenter(loginVC, coordinator)
        loginVC.presenter = loginPresenter
        coordinator.start()
    }
    
    func testPurposes() {
        let profileVK = VKProfileVC()
        let coordinator = VKProfileCoordinator(navController, rootVC: profileVK)
        let modelPost = VKProfileModel()
        let modelPhoto = VKPhotoLibModel()
        let vkPresenter = VKProfilePresenter(modelPost, modelPhotoLib: modelPhoto, profileVK, coordinator)
        profileVK.dataDelegate = vkPresenter
        profileVK.presenter = vkPresenter
        coordinator.start()
    }
    
    func testWithTabBar() {
        let tabBar = TabBarMain()
        let tabBarCoordinator = TabBarMainCoordinator(tabBar, navController)
        let tabBarPresenter = TabBarPresenter(tabBar, tabBarCoordinator)
        tabBar.tapDelegate = tabBarPresenter
        tabBarCoordinator.start()
        navController.isNavigationBarHidden = true
    }
}
