//
//  VKPostFeedCell.swift
//  VKclient
//
//  Created by Dmitrii KRY on 22.10.2021.
//

import Foundation
import UIKit
import SnapKit

class VKPostFeedCell: UICollectionViewCell {
    
    var presenter: VKFeedPresenterDelegate?
    
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
    
    let additionalInfo: UIButton = {
        let image = UIImage(named: "hDots")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        return view
    }()
  
    let postTextAndImage: VKPostSubView = {
        let view = VKPostSubView()
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(30)
        }
        
        userName.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        userNameSubtitle.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(userName.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        additionalInfo.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.trailing.equalTo(self).inset(16)
            make.centerY.equalTo(ava.snp.centerY)
        }
        
        postTextAndImage.snp.makeConstraints { make in
            make.top.equalTo(ava.snp.bottom).offset(15)
            make.height.equalTo(200)
            make.trailing.leading.equalTo(self)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(ava,userName,userNameSubtitle, additionalInfo, postTextAndImage)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VKPostFeedCell {
  
}

