//
//  VKPhotoFolderHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 27.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKPhotoFolderHeader: UICollectionReusableView {
    
    let albumsLabel: UILabel = {
        let view = UILabel()
        view.text = "Albums"
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .red
        return view
    }()
    
    let albumsCount: UILabel = {
        let view = UILabel()
        view.text = "1"
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let showAll: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("ShowAll", for: .normal)
//        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
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
        
        albumsLabel.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.top.equalTo(upperLine).offset(15)
            make.leading.equalTo(self)
        }
        
        albumsCount.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.centerY.equalTo(albumsLabel)
            make.leading.equalTo(albumsLabel.snp.trailing).offset(15)
        }
        
        showAll.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.centerY.equalTo(albumsLabel)
            make.trailing.equalTo(self)
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(upperLine, albumsLabel, albumsCount, showAll)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
