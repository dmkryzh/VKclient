//
//  VKProfileOptionsVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation
import UIKit
import SnapKit

protocol VKProfileOptionsDelegate {
    func generalInfoIsTapped()
}

class VKProfileOptionsVC: UIViewController {
    
    var presenter: VKProfileOptionsDelegate?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy var closeButton: UIButton = {
        let image = UIImage(systemName: "xmark")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let profile: UILabel = {
        let view = UILabel()
        view.text = "Профиль"
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    let mainInfo: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Основная информация", for: .normal)
        view.addTarget(self, action: #selector(infoBttnHandler), for: .touchUpInside)
        return view
    }()
    
    let contacts: UILabel = {
        let view = UILabel()
        view.text = "Контакты"
        return view
    }()
    
    let interests: UILabel = {
        let view = UILabel()
        view.text = "Интересы"
        return view
    }()
    
    let degree: UILabel = {
        let view = UILabel()
        view.text = "Образование"
        return view
    }()
    
    let career: UILabel = {
        let view = UILabel()
        view.text = "Карьера"
        return view
    }()
    
    lazy var viewConfig = { [self] in
        view.backgroundColor = .white
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
    }
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safe)
        }
        
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.top.equalTo(containerView).offset(45)
            make.leading.equalTo(containerView).offset(25)
        }
        
        profile.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(closeButton.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(25)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(250)
            make.top.equalTo(profile.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        mainInfo.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }

        contacts.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(mainInfo.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }

        interests.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(contacts.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }

        degree.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(interests.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }

        career.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(degree.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
            make.bottom.equalTo(containerView)
        }
    }
    
    override func viewDidLoad() {
        viewConfig()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(closeButton, profile, line, mainInfo, contacts, interests, degree, career)
        setupConstraints()
    }
}

extension VKProfileOptionsVC {
    @objc func infoBttnHandler() {
        presenter?.generalInfoIsTapped()
    }
}

