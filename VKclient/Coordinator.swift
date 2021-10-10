//
//  Coordinator.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navController: UINavigationController { get set }
    var rootVC: UIViewController { get set }
    func start()
    
}
