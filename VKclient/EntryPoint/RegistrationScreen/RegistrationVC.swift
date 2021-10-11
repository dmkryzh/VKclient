//
//  RegistrationVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import SnapKit

class RegistrationVC: UIViewController {
    
    var presenter: RegPresenterProtocol?
    
    let registerLabel: UILabel = {
        let view = UILabel()
        view.text = "Зарегистрироваться"
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    let enterNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Введите номер"
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    
    let infoLabel: UILabel = {
        let view = UILabel()
        view.text = "Ваш номер будет использоваться для входа в аккаунт"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    let consentLabel: UILabel = {
        let view = UILabel()
        view.text = "Нажимая кнопку “Далее” вы принимаете пользовательское Соглашение и политику конфиденциальности"
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        view.textAlignment = .center
        view.numberOfLines = 0
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
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Далее", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.layer.cornerRadius = 10
        view.addTarget(presenter, action: #selector(presenter?.nextButtonPressed), for: .touchUpInside)
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        registerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.height.equalTo(20)
            make.width.equalTo(220)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        enterNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(70)
            make.height.equalTo(20)
            make.width.equalTo(130)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(enterNumberLabel.snp.bottom).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(220)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        smsInputText.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(smsInputText.snp.bottom).offset(70)
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        consentLabel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(250)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubviews(registerLabel, enterNumberLabel, infoLabel, smsInputText, nextButton, consentLabel)
        setupConstraints()
    }
}
