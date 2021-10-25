//
//  ProfilePostSubView.swift
//  VKclient
//
//  Created by Dmitrii KRY on 22.10.2021.
//

import Foundation
import UIKit

class ProfilePostSubView: UIView {

    lazy var postText: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        return view
    }()
    
    lazy var expandPostBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Показать полностью...", for: .normal)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    var postPhoto: UIImageView = {
        let view = UIImageView()
        view.contentMode = .topLeft
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        line.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.width.equalTo(1)
            make.leading.equalTo(self).offset(30)
            make.bottom.equalTo(self).inset(20)
        }
        
        postText.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(line.snp.trailing).offset(25)
            make.trailing.equalTo(self).inset(16)
        }
        
        expandPostBtt.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(180)
            make.leading.equalTo(line.snp.trailing).offset(25)
        }
        
        postPhoto.snp.makeConstraints { make in
            make.top.equalTo(expandPostBtt.snp.bottom).offset(10)
            make.leading.equalTo(line.snp.trailing).offset(25)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(line, postText, postPhoto, expandPostBtt)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
