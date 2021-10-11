//
//  LoginVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    var presenter: LoginPresenter?
    
    let welcomeBackLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let enterNumberLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let enterNumberText: UITextField = {
        let view = UITextField()
        return view
    }()
    
    let confirmButton: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
}
