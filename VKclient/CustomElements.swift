//
//  CustomElements.swift
//  VKclient
//
//  Created by Dmitrii KRY on 13.10.2021.
//

import Foundation
import UIKit

//class CustomElements {
//
//    static var shared: CustomElements = {
//
//        let instance  = CustomElements()
//
//        let backButton: UIButton = {
//            let view = UIButton(type: .system)
//            let image = UIImage(named: "backButton")
//            view.setImage(image, for: .normal)
//            view.setTitle("", for: .normal)
//            view.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
//            return view
//        }()
//
//        return instance
//    }()
//
//    private init() {}
//
//}

struct CustomElements {
    
    static let shared = CustomElements()
    
    let backButton: UIButton = {
        let view = UIButton(type: .system)
        let image = UIImage(named: "backButton")
        view.setImage(image, for: .normal)
        view.setTitle("", for: .normal)
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        return view
    }()
    
    let backButtonItem: UIBarButtonItem = {
        
        let backButton: UIButton = {
            let view = UIButton(type: .system)
            let image = UIImage(named: "backButton")
            view.setImage(image, for: .normal)
            view.setTitle("", for: .normal)
            view.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
            return view
        }()
        
        let view = UIBarButtonItem(customView: backButton)
        return view
    }()
    
    private init() { }
}
