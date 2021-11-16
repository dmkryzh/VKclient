//
//  VKPostSectionHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 04.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKPostSectionHeader: UICollectionReusableView {
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let separator: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        return view
    }()
    
    let date: Date = {
        let data = Date()
        return data
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    lazy var dateContainer: UILabel = {
        let view = UILabel()
        view.tintColor = .black
        view.text = dateFormatter.string(from: date)
        view.textAlignment = .center
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
            make.centerY.equalTo(self)
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(140)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        dateContainer.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(120)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(line, separator)
        separator.addSubview(dateContainer)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
