//
//  VKFullPostSettingsVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation
import UIKit
import SnapKit

protocol VKFullPostSettingsDelegate {
    func test()
}

class VKFullPostSettingsVC: UIViewController {
    
    var presenter: VKFullPostSettingsDelegate?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let save: UILabel = {
        let view = UILabel()
        view.text = "Сохранить в закладках"
        return view
    }()
    
    let notificationOn: UILabel = {
        let view = UILabel()
        view.text = "Включить уведомления"
        return view
    }()
    
    let saveLink: UILabel = {
        let view = UILabel()
        view.text = "Сохранить ссылку"
        return view
    }()
    
    let share: UILabel = {
        let view = UILabel()
        view.text = "Поделиться в..."
        return view
    }()
    
    let cancel: UILabel = {
        let view = UILabel()
        view.text = "Отменить подписку"
        return view
    }()
    
    let report: UILabel = {
        let view = UILabel()
        view.text = "Пожаловаться"
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
        
        line.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(40)
            make.top.equalTo(containerView).offset(25)
            make.centerX.equalTo(containerView)
        }
        
        notificationOn.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(line.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(16)
        }
  
        
        saveLink.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(notificationOn.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }

        share.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(saveLink.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }

        cancel.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(share.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }

        report.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(cancel.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }

    }
    
    override func viewDidLoad() {
        viewConfig()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(line, save, notificationOn, saveLink, share, cancel, report)
        setupConstraints()
    }
}

extension VKFullPostSettingsVC {
    @objc func settingsBttnHandler() {
        presenter?.test()
    }
}

