//
//  VKCollectionCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.01.2022.
//

import Foundation
import UIKit
import Popover

class VKCollectionCoordinator: Coordinator {
    
    var slideInTransitioningDelegate = SliderPresentationManager()
    
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
    
    init(_ navi: UINavigationController, rootVC: UIViewController) {
        self.rootVC = rootVC
        navController = navi
        customiseNavBar()
    }
}

extension VKCollectionCoordinator: VKCollectionFlowDelegate {
    
    func editFlowIsChosen() {
        guard let mainVC = self.rootVC as? VKProfileVC else { return }
        let rootVC = VKProfileEditVC()
        rootVC.transitioningDelegate = mainVC.sliderTransitionDelegate
        rootVC.modalPresentationStyle = .custom
        let coordinator = VKProfileEditCoordinator(navController, rootVC: rootVC)
        let presenter = VKProfileEditPresenter(rootVC, coordinator)
        rootVC.presenter = presenter
        coordinator.start()
    }
    
    func photoFlowIsChosen() {
        let photoVC = VKPhotoLibVC()
        let coordinator = VKPhotoLibCoordinator(navController, photoVC)
        let data = VKPhotoLibModel()
        let photoPresenter = VKPhotoLibPresenter(photoVC, data, coordinator)
        photoVC.presenter = photoPresenter
        photoVC.model = photoPresenter
        coordinator.start()
    }
    
    func postFullViewIsChosen() {
        let postVK = VKFullPostVC()
        let coordinator = VKFullPostCoordinator(navController, postVK)
        let postPresenter = VKFullPostPresenter(postVK, coordinator)
        postVK.presenter = postPresenter
        coordinator.start()
    }
    
    
    func postSettingsIsChosen(_ sender: Any) {
        guard let rootVC = rootVC as? VKProfileVC else { return }
        guard let viewButton = sender as? UIButton else { return }
        let viewButtonConverted = rootVC.view.convert(viewButton.bounds, from: viewButton)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 260))
        container.addSubview(rootVC.tableView)
        rootVC.popOver.show(container, point: CGPoint(x: viewButtonConverted.origin.x, y: viewButtonConverted.origin.y))
    }
    
    func settingsFlowIsChosen() {
        guard let mainVC = self.rootVC as? VKProfileVC else { return }
        let rootVC = VKProfileOptionsVC()
        rootVC.transitioningDelegate = mainVC.sliderTransitionDelegate
        rootVC.modalPresentationStyle = .custom
        let coordinator = VKProfileOptionsCoordinator(navController, rootVC: rootVC)
        let presenter = VKProfileOptionsPresenter(rootVC, coordinator)
        rootVC.presenter = presenter
        coordinator.start()
    }
}
