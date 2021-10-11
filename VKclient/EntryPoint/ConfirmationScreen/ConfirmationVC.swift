//
//  ConfirmationVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

class ConfirmationVC: UIViewController {
    
    var presenter: ConfirmationPresenter?

    let confirmationLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let sentSmsLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let enterCodeLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let smsInputText: UITextField = {
        let view = UITextField()
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let successLogo: UIImageView = {
        let image = UIImage(named: "")
        let view = UIImageView(image: image)
        return view
    }()
}
