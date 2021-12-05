//
//  VKFullPostCommentReply.swift
//  VKclient
//
//  Created by Dmitrii KRY on 24.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKFullPostCommentReply: UICollectionViewCell {
    
    let ava: UIImageView = {
        let image = UIImage(named: "pepe")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 7.5
        view.clipsToBounds = true
        return view
    }()
    
    let likesQuantity: UILabel = {
        let view = UILabel()
        view.text = "30"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let like: UIImageView = {
        let image = UIImage(systemName: "heart")
        let view = UIImageView(image: image)
        return view
    }()
    
    let userName: UILabel = {
        let view = UILabel()
        view.text = "Default User"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let comment: UILabel = {
        let view = UILabel()
        view.text = "Dislike, unfollowing"
        view.font = .systemFont(ofSize: 12)
        view.numberOfLines = 0
        return view
    }()
    
    let reply: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Ответить", for: .normal)
        view.tintColor = .label
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
        return dateFormatter
    }()
    
    lazy var dateView: UILabel = {
        let view = UILabel()
        view.text = dateFormatter.string(from: date)
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(15)
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(40)
        }
        
        userName.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.centerY.equalTo(ava)
            make.leading.equalTo(ava.snp.trailing).offset(5)
        }
        
        comment.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.top.equalTo(ava.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(5)
        }
        
        dateView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(comment.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(5)
            make.bottom.equalTo(self)
        }
        
        likesQuantity.snp.makeConstraints { make in
            make.width.equalTo(18)
            make.centerY.equalTo(ava)
            make.trailing.equalTo(self).inset(10)
        }
        
        like.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(ava)
            make.trailing.equalTo(self).inset(30)
        }
     
        reply.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.trailing.equalTo(self).inset(10)
            make.bottom.equalTo(dateView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(ava, userName, comment, dateView, likesQuantity, like, reply)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
