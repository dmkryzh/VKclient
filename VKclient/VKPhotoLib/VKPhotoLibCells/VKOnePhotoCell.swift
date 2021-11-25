//
//  VKOnePhotoCell.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKOnePhotoCell: UICollectionViewCell {
    
    let photoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.tintColor = .black
        return view
    }()
    
    lazy var setupConstrains = { [self] in
        photoImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        contentView.addSubviews(photoImage)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

