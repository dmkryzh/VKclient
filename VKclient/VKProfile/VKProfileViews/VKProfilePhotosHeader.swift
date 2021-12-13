//
//  VKProfilePhotosHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 13.12.2021.
//

import Foundation
import UIKit

class VKProfilePhotosHeader: UICollectionReusableView {
    
    let photoLibLabel: UILabel = {
        let view = UILabel()
        view.text = "Фотографии XX"
        view.textColor = .label
        return view
    }()
    
    let photoLibArrow: UIButton = {
        let arrowConfig = UIImage.SymbolConfiguration(textStyle: .title3)
        let image = UIImage(systemName: "chevron.forward", withConfiguration: arrowConfig)
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        photoLibArrow.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(15)
            make.top.equalTo(self)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self)
        }
        
        photoLibLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.centerY.equalTo(photoLibArrow.snp.centerY)
            make.leading.equalTo(self).offset(16)
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(photoLibLabel, photoLibArrow)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

