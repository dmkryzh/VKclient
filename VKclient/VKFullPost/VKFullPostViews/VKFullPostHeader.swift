//
//  VKFullPostHeader.swift
//  VKclient
//
//  Created by Dmitrii KRY on 24.11.2021.
//

import Foundation
import UIKit

class VKFullPostHeader: UICollectionViewCell {

let upperLine: UILabel = {
    let view = UILabel()
    view.backgroundColor = .black
    return view
}()

let ava: UIImageView = {
    let image = UIImage(named: "pepe")
    let view = UIImageView(image: image)
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.clipsToBounds = true
    view.layer.borderColor = UIColor.white.cgColor
    return view
}()

let userName: UILabel = {
    let view = UILabel()
    view.text = "Default User"
    view.font = .systemFont(ofSize: 12)
    return view
}()

let userNameSubtitle: UILabel = {
    let view = UILabel()
    view.text = "developer"
    view.font = .systemFont(ofSize: 12)
    return view
}()

let postPicture: UIImageView = {
    let image = UIImage(named: "child")
    let view = UIImageView(image: image)
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    return view
}()

let textView: UILabel = {
    let view = UILabel()
    view.text = """
With prototyping in Figma, you can create multiple flows for your prototype in one page to preview a user's full journey and experience through your designs. A flow is a path users take through the network of connected frames that make up your prototype. For example, you can create a prototype for a shopping app that includes a flow for account creation, another for browsing items, and another for the checkout process–all in one page.

When you add a connection between two frames with no existing connections in your prototype, a flow starting point is created. You can create multiple flows using the same network of connected frames by adding different flow starting points.
"""
    view.numberOfLines = 0
    return view
}()

let bottomLine: UILabel = {
    let view = UILabel()
    view.backgroundColor = .black
    return view
}()
    
    lazy var setupConstraints = { [self] in
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(upperLine.snp.bottom).offset(15)
            make.leading.equalTo(self.snp.leading).offset(30)
        }
        
        userName.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(250)
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        userNameSubtitle.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(100)
            make.top.equalTo(userName.snp.bottom).offset(1)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        postPicture.snp.makeConstraints { make in
            make.height.equalTo(220)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.top.equalTo(postPicture.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(textView.snp.bottom).offset(3)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
//            make.bottom.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(upperLine, ava, userName, userNameSubtitle, postPicture, textView, bottomLine)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
