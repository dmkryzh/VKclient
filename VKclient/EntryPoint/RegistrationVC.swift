//
//  RegistrationVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import SnapKit

class RegistrationVC: UIViewController {
    
    weak var coordinator: Coordinator?
    
    let registerLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let enterNumberLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let infoLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let consentLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let smsInputText: UITextField = {
        let view = UITextField()
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
}
