//
//  LoginVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    let welcomeBackLabel: UILabel = {
        let view = UILabel()
        view.text = "С возвращением"
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    let enterNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Введите номер телефона для входа в приложение"
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    
    let smsInputText: UITextField = {
        let view = UITextField()
        view.placeholder = "+7___-___-__-__"
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.textAlignment = .center
        return view
    }()
    
    lazy var confirmationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Подтвердить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        welcomeBackLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(180)
            make.height.equalTo(20)
            make.width.equalTo(220)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        enterNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeBackLabel.snp.bottom).offset(30)
            make.height.equalTo(20)
            make.width.equalTo(130)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        smsInputText.snp.makeConstraints { make in
            make.top.equalTo(enterNumberLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        confirmationButton.snp.makeConstraints { make in
            make.top.equalTo(smsInputText.snp.bottom).offset(150)
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubviews(welcomeBackLabel, enterNumberLabel, smsInputText, confirmationButton)
        setupConstraints()
    }

    
    
}
