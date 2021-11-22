//
//  VKToolsCoordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.11.2021.
//

import Foundation
import UIKit
import SnapKit
import WeScan
import AVFoundation

class VKToolsCoordinator: Coordinator {
    
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
        //        customiseNavBar()
    }
}

extension VKToolsCoordinator: VKToolPresenterDelegate {
    
    func startScan() {
        guard let vc = rootVC as? VKToolsVC else { return }
        let scanner = ImageScannerController()
        scanner.imageScannerDelegate = vc
        scanner.navigationBar.backgroundColor = .blue
        scanner.toolbar.backgroundColor = .blue
        navController.modalPresentationStyle = .overFullScreen
        navController.present(scanner, animated: true)
    }
    
    func showScanScreen() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            startScan()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.sync {
                        self.startScan()
                    }
                }
            }
            
        case .denied: // The user has previously denied access.
            return
            
        case .restricted: // The user can't grant access due to restrictions.
            return
            
        @unknown default:
            fatalError()
            
        }
        
    }
    
}
