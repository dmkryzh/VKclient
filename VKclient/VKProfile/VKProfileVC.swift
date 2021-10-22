//
//  VKProfileVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit
import SnapKit

final class VKProfileVC: UIViewController {
    
    var delegate: VKProfilePresenterProtocol?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let ava: UIImageView = {
        let image = UIImage(named: "pepe")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let userName: UILabel = {
        let view = UILabel()
        view.text = "Default User"
        return view
    }()
    
    let userNameSubtitle: UILabel = {
        let view = UILabel()
        view.text = "developer"
        return view
    }()
    
    let detailSubtitle: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Detailed information", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let exclamationMark: UIImageView = {
        let image = UIImage(systemName: "exclamationmark.circle.fill")
        let view = UIImageView(image: image)
        view.tintColor = UIColor(named: "deepBlueColor")
        return view
    }()
    
    let editBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Редактировать", for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var postsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nпубликаций", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var subscriptionsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписок", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var followersBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписчиков", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var stackBtts: UIStackView = {
        let view = UIStackView(arrangedSubviews: [postsBtt, subscriptionsBtt, followersBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 25
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let createPostBtt: UIButton = {
        let image = UIImage(systemName: "pencil.circle")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.setTitle("Запись", for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createStoryBtt: UIButton = {
        let image = UIImage(systemName: "livephoto")
        let view = UIButton(type: .system)
        view.setTitle("История", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createPhotoBtt: UIButton = {
        let image = UIImage(systemName: "camera.circle")
        let view = UIButton(type: .system)
        view.setTitle("Фото", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    lazy var stackBttsSec: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createPostBtt, createStoryBtt, createPhotoBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 60
        return view
    }()
    
    let photosCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        return view
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.collectionViewLayout = photosCollectionLayout
        view.register(VKProfilePhotoLibCell.self, forCellWithReuseIdentifier: "VKProfilePhotoLib")
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
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
    
    
    let postsCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        return view
    }()
    
    lazy var postsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: postsCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKProfilePostFeedCell.self, forCellWithReuseIdentifier: "VKProfilePostFeed")
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safe)
        }
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(containerView.snp.top).offset(15)
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        userName.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(containerView).offset(20)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        userNameSubtitle.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(100)
            make.top.equalTo(userName.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        exclamationMark.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        detailSubtitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(140)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(exclamationMark.snp.trailing).offset(5)
        }
        
        editBtt.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
            make.top.equalTo(detailSubtitle.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        stackBtts.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(editBtt.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(400)
            make.top.equalTo(stackBtts.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        stackBttsSec.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        photoLibLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.top.equalTo(stackBttsSec.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }
        
        photoLibArrow.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(15)
            make.trailing.equalTo(containerView).inset(16)
            make.centerY.equalTo(photoLibLabel.snp.centerY)
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.height.equalTo(68)
            make.top.equalTo(photoLibLabel.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView)
        }
        
        myPostsLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.top.equalTo(photosCollectionView.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(16)
        }
        
        searchPosts.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.trailing.equalTo(containerView).inset(16)
            make.centerY.equalTo(myPostsLabel.snp.centerY)
        }
        
        postsCollectionView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.top.equalTo(myPostsLabel.snp.bottom).offset(15)
            make.leading.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView.snp.bottom)
        }
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubviews(containerView, ava, userName, userNameSubtitle, exclamationMark, detailSubtitle, editBtt, stackBtts, line, stackBttsSec, photoLibLabel, photoLibArrow, photosCollectionView, myPostsLabel, searchPosts, postsCollectionView)
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        createPostBtt.alignImageAndTitleVertically()
        createPhotoBtt.alignImageAndTitleVertically()
        createStoryBtt.alignImageAndTitleVertically()
    }
    
}

extension VKProfileVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == photosCollectionView {
            return CGSize(width: 72, height: 68)
        }
        else {
            return CGSize(width: view.bounds.width, height: 380)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == photosCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}

extension VKProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == photosCollectionView {
            return VKPhotoLibModel.photosForTesting.count + 1
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == photosCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKProfilePhotoLib", for: indexPath) as? VKProfilePhotoLibCell else { return UICollectionViewCell(frame: .zero)  }
            
            if indexPath.item == VKPhotoLibModel.photosForTesting.count {
                let threeDots = UIImage(systemName: "arrow.right")
                cell.photoImage.image = threeDots
            } else {
                let photo = UIImage(named: VKPhotoLibModel.photosForTesting[indexPath.item])
                
                cell.photoImage.image = photo
            }
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKProfilePostFeed", for: indexPath) as? VKProfilePostFeedCell else { return UICollectionViewCell(frame: .zero)  }
            return cell
            
        }
    }
    
}

extension VKProfileVC: UICollectionViewDelegate {
    
}

