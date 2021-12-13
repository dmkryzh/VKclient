//
//  VKProfilePostHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 13.12.2021.
//

import Foundation
import UIKit

class VKProfilePostHeader: UICollectionReusableView {
    
    let myPostsLabel: UILabel = {
        let view = UILabel()
        view.text = "Мои посты"
        view.textColor = .label
        return view
    }()
    
    let searchPosts: UIButton = {
        let arrowConfig = UIImage.SymbolConfiguration(textStyle: .title3)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: arrowConfig)
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        searchPosts.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.top.equalTo(self)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self)
        }
        
        myPostsLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.leading.equalTo(self).offset(16)
            make.centerY.equalTo(searchPosts.snp.centerY)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(myPostsLabel, searchPosts)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
