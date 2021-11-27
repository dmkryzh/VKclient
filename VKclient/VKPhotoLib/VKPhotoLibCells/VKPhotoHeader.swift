//
//  VKPhotoHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 27.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKPhotoHeader: UICollectionReusableView {
    
    let allPhotosLabel: UILabel = {
        let view = UILabel()
        view.text = "All Photos"
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .red
        return view
    }()
    
    let photoCount: UILabel = {
        let view = UILabel()
        view.text = "20"
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let upperLine: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()

    lazy var setupConstraints = { [self] in
        
        upperLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self)
        }
        
        allPhotosLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(upperLine).offset(15)
            make.leading.equalTo(self)
        }
        
        photoCount.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.centerY.equalTo(allPhotosLabel)
            make.leading.equalTo(allPhotosLabel.snp.trailing).offset(15)
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(upperLine, allPhotosLabel, photoCount)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


