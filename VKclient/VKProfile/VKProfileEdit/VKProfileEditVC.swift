//
//  VKProfileEditVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation
import UIKit
import SnapKit

protocol VKProfileEditVCDelegate {
    func test()
}

import Foundation
import UIKit
import SnapKit

class VKProfileEditVC: UIViewController {
    
    var presenter: VKProfileEditVCDelegate?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy var backButton: UIButton = {
        let image = UIImage(systemName: "arrow.left")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        return view
    }()
    
    let name: UILabel = {
        let view = UILabel()
        view.text = "Default user"
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    let upperLine: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let bookmarkIcon: UIImageView = {
        let image = UIImage(systemName: "star")
        let view = UIImageView(image: image)
        return view
    }()
    
    let likeIcon: UIImageView = {
        let image = UIImage(systemName: "heart")
        let view = UIImageView(image: image)
        return view
    }()
    
    let fileIcon: UIImageView = {
        let image = UIImage(systemName: "square.and.arrow.up")
        let view = UIImageView(image: image)
        return view
    }()
    
    let archiveIcon: UIImageView = {
        let image = UIImage(systemName: "archivebox")
        let view = UIImageView(image: image)
        return view
    }()
    
    let settingIcon: UIImageView = {
        let image = UIImage(systemName: "gear")
        let view = UIImageView(image: image)
        return view
    }()
    
    let bookmark: UILabel = {
        let view = UILabel()
        view.text = "Закладки"
        return view
    }()
    
    let like: UILabel = {
        let view = UILabel()
        view.text = "Понравилось"
        return view
    }()
    
    let files: UILabel = {
        let view = UILabel()
        view.text = "Файлы"
        return view
    }()
    
    let archive: UILabel = {
        let view = UILabel()
        view.text = "Архивы"
        return view
    }()
    
    let bottomLine: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let settings: UILabel = {
        let view = UILabel()
        view.text = "Настройки"
        return view
    }()
    
    lazy var viewConfig = { [self] in
        view.backgroundColor = .white
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
    }
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safe)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.top.equalTo(containerView).offset(45)
            make.leading.equalTo(containerView).offset(25)
        }
        
        name.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(25)
        }
        
        upperLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(250)
            make.top.equalTo(name.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        bookmarkIcon.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(upperLine.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        bookmark.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.leading.equalTo(bookmarkIcon.snp.trailing).offset(25)
            make.centerY.equalTo(bookmarkIcon)
        }
        
        likeIcon.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(bookmarkIcon.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        like.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.leading.equalTo(likeIcon.snp.trailing).offset(25)
            make.centerY.equalTo(likeIcon)
        }
        
        fileIcon.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(likeIcon.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        files.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.leading.equalTo(fileIcon.snp.trailing).offset(25)
            make.centerY.equalTo(fileIcon)
        }
        
        archiveIcon.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(fileIcon.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        archive.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.leading.equalTo(archiveIcon.snp.trailing).offset(25)
            make.centerY.equalTo(archiveIcon)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(250)
            make.top.equalTo(archiveIcon.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(bottomLine.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(25)
        }
        
        settings.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.leading.equalTo(settingIcon.snp.trailing).offset(25)
            make.centerY.equalTo(settingIcon)
        }
    }
    
    override func viewDidLoad() {
        viewConfig()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(backButton, name, upperLine, bookmarkIcon, bookmark, likeIcon, like, fileIcon, files, archiveIcon, archive, bottomLine, settingIcon, settings)
        setupConstraints()
    }
}

extension VKProfileEditVC {
  
}

