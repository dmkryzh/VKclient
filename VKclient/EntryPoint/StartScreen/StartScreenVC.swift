//
//  StartScreenVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//

import Foundation
import UIKit
import SnapKit

protocol StartPresenterProtocol {
    func registerButtonPressed()
    func accountIsExistButtonPressed()
}

protocol StartFlowDelegate {
    func registrationFlowChosen()
    func loginFlowChosen()
    func testPurposes()
    func testWithTabBar()
    func testMaterialTab()
}

class StartScreenVC: UIViewController {
    
    var presenter: StartPresenterProtocol?
    
    lazy var registerButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.setTitle("Войти", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        view.layer.cornerRadius = 20
        view.tintColor = .white
        view.addTarget(self, action: #selector(registerBttnHandler), for: .touchUpInside)
        return view
    }()
    
    let logoView: UIImageView = {
        let image = UIImage(named: "startLogoDark")
        let view = UIImageView(image: image)
        view.layer.cornerRadius = 150
        view.layer.masksToBounds = true
        return view
    }()
    
    //    lazy var accExistsButton: UIButton = {
    //        let view = UIButton(type: .system)
    //        view.backgroundColor = .clear
    //        view.setTitle("Уже есть аккаунт", for: .normal)
    //        view.addTarget(presenter, action: #selector(presenter?.accountIsExistButtonPressed), for: .touchUpInside)
    //        return view
    //    }()

    lazy var setupConstraints = { [self] in
  
        logoView.snp.makeConstraints { make in
            make.height.equalTo(550)
            make.width.equalTo(400)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(logoView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        
//        accExistsButton.snp.makeConstraints { make in
//            make.height.equalTo(50)
//            make.width.equalTo(300)
//            make.top.equalTo(registerButton.snp.bottom).offset(40)
//            make.centerX.equalToSuperview()
//        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubviews(logoView, registerButton)
        setupConstraints()
    }
}

//MARK: ACTIONS

extension StartScreenVC {
    @objc func registerBttnHandler() {
        presenter?.registerButtonPressed()
    }
}
