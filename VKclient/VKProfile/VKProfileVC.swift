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
    
    let ava: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let userName: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let userNameSubtitle: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let datailSubtitle: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let exclamationMark: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let editBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let postsBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let subscriptionsBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let followersBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let createPostBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let createStoryBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let createPhotoBtt: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    let photosCollectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemYellow
    }
    
}
