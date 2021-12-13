//
//  VKProfileHeaderView.swift.swift
//  VKclient
//
//  Created by Dmitrii KRY on 13.12.2021.
//

import Foundation
import UIKit

class VKProfileHeaderView: UICollectionReusableView {
    
    let ava: UIImageView = {
        let image = UIImage(named: "pepe")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let userName: UILabel = {
        let view = UILabel()
        view.text = "Default User"
        return view
    }()
    
    let userNameSubtitle: UILabel = {
        let view = UILabel()
        view.text = "developer"
        return view
    }()
    
    let detailSubtitle: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Detailed information", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let exclamationMark: UIImageView = {
        let image = UIImage(systemName: "exclamationmark.circle.fill")
        let view = UIImageView(image: image)
        view.tintColor = UIColor(named: "deepBlueColor")
        return view
    }()
    
    let editBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Редактировать", for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let message: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Cообщение", for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let call: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Позвонить", for: .normal)
        view.backgroundColor = .lightGray
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var altStackBtts: UIStackView = {
        let view = UIStackView(arrangedSubviews: [message, call])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 30
        view.isHidden = true
        return view
    }()
    
    lazy var postsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nпубликаций", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var subscriptionsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписок", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var followersBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписчиков", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var stackBtts: UIStackView = {
        let view = UIStackView(arrangedSubviews: [postsBtt, subscriptionsBtt, followersBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 25
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let createPostBtt: UIButton = {
        let image = UIImage(systemName: "pencil.circle")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.setTitle("Запись", for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createStoryBtt: UIButton = {
        let image = UIImage(systemName: "livephoto")
        let view = UIButton(type: .system)
        view.setTitle("История", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createPhotoBtt: UIButton = {
        let image = UIImage(systemName: "camera.circle")
        let view = UIButton(type: .system)
        view.setTitle("Фото", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    lazy var stackBttsSec: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createPostBtt, createStoryBtt, createPhotoBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 60
        return view
    }()
    

    
    lazy var setupConstraints = { [self] in
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(30)
        }
        
        userName.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        userNameSubtitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.top.equalTo(userName.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        exclamationMark.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        detailSubtitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(140)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(exclamationMark.snp.trailing).offset(5)
        }
        
        editBtt.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
            make.top.equalTo(detailSubtitle.snp.bottom).offset(25)
            make.centerX.equalTo(self)
        }
        
        altStackBtts.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
            make.top.equalTo(detailSubtitle.snp.bottom).offset(25)
            make.centerX.equalTo(self)
        }
        
        stackBtts.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(editBtt.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).inset(16)
            make.top.equalTo(stackBtts.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        
        stackBttsSec.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func updateView() {
        
        if !altStackBtts.isHidden {
            stackBttsSec.removeFromSuperview()
            line.snp.remakeConstraints { make in
                make.height.equalTo(1)
                make.leading.equalTo(self).offset(16)
                make.trailing.equalTo(self).inset(16)
                make.centerX.equalTo(self)
                make.top.equalTo(stackBtts.snp.bottom).offset(15)
                make.bottom.equalTo(self).inset(15)
            }
        }
        
        layoutSubviews()
        
    }
    
    override func layoutSubviews() {
        createPostBtt.alignImageAndTitleVertically()
        createPhotoBtt.alignImageAndTitleVertically()
        createStoryBtt.alignImageAndTitleVertically()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(ava, userName, userNameSubtitle, exclamationMark, detailSubtitle, editBtt, altStackBtts, stackBtts, line, stackBttsSec)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


