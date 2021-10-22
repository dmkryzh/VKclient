//
//  ProfilePostSubView.swift
//  VKclient
//
//  Created by Dmitrii KRY on 22.10.2021.
//

import Foundation
import UIKit

class ProfilePostSubView: UIView {
    
    let text =
        """
        123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123123 123123123 123123123 123123123123
        """
    
    lazy var postText: UILabel = {
        let view = UILabel()
        view.numberOfLines = 4
        view.text = text
        return view
    }()
    
    let expandPostBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Показать полностью...", for: .normal)
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let postPhoto: UIImageView = {
        let image = UIImage(named: "1ava")
        let view = UIImageView(image: image)
        view.contentMode = .left
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
            make.width.equalTo(300)
            make.leading.equalTo(line.snp.trailing).offset(25)
            make.trailing.equalTo(self).inset(16)
        }
        
        expandPostBtt.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom)
            make.height.equalTo(15)
            make.width.equalTo(140)
            make.leading.equalTo(line.snp.trailing).offset(25)
        }
        
        postPhoto.snp.makeConstraints { make in
            make.top.equalTo(expandPostBtt.snp.bottom).offset(10)
            make.width.equalTo(300)
            make.leading.equalTo(line.snp.trailing).offset(25)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(10)
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
