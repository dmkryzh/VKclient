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
        view.text = "Подтверждение регистрации"
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    lazy var sentSmsLabel: UILabel = {
        let view = UILabel()
        let text = NSAttributedString(string: "Мы отправили SMS с кодом на номер ", attributes: [.font : UIFont.systemFont(ofSize: 12, weight: .regular)])
        let passedNumber = NSAttributedString(string: presenter?.passedNumber ?? "", attributes: [.font : UIFont.systemFont(ofSize: 14, weight: .heavy)])
        let fullText = NSMutableAttributedString(attributedString: text)
        fullText.append(passedNumber)
        view.attributedText = fullText
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let enterCodeLabel: UILabel = {
        let view = UILabel()
        view.text = "Введите код из SMS"
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        return view
    }()
    
    let smsInputText: UITextField = {
        let view = UITextField()
        view.placeholder = "___-___-___"
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.textAlignment = .center
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.layer.cornerRadius = 10
        return view
    }()
    
    let successLogo: UIImageView = {
        let image = UIImage(named: "rusFlag")
        let view = UIImageView(image: image)
        return view
    }()
    
    lazy var setupConstrains = { [self] in
        confirmationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.height.equalTo(20)
            make.width.equalTo(280)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        sentSmsLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(70)
            make.height.equalTo(50)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        enterCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(sentSmsLabel.snp.bottom).offset(120)
            make.height.equalTo(15)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        smsInputText.snp.makeConstraints { make in
            make.top.equalTo(enterCodeLabel.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(smsInputText.snp.bottom).offset(70)
            make.height.equalTo(50)
            make.width.equalTo(260)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        successLogo.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(40)
            make.height.equalTo(60)
            make.width.equalTo(80)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubviews(confirmationLabel, sentSmsLabel, enterCodeLabel, smsInputText, registerButton, successLogo)
        setupConstrains()
    }
}
