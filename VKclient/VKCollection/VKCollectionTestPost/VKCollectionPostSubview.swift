//
//  VKCollectionPostSubview.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.01.2022.
//

import Foundation
import UIKit

class VKCollectionPostSubview: UIView {

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

        postText.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(55)
            make.trailing.equalTo(self).inset(16)
        }
        
        expandPostBtt.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom).offset(5)
            make.width.equalTo(180)
            make.leading.equalTo(self).offset(55)
        }

        postPhoto.snp.makeConstraints { make in
            make.top.equalTo(expandPostBtt.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(55)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(20)
        }

        line.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.width.equalTo(1)
            make.leading.equalTo(self).offset(30)
            make.bottom.equalTo(postPhoto.snp.bottom)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(postText, expandPostBtt, postPhoto, line)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
