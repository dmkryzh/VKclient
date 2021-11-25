//
//  VKPhotoLibVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.10.2021.
//

import UIKit
import SnapKit
import Popover

protocol VKPhotoLibVCDelegate {
    func test()
}

final class VKPhotoLibVC: UIViewController {
    
    
    let sliderTransitionDelegate = SliderPresentationManager()
    
    var presenter: VKPhotoLibVCDelegate?
    
    /// -- NavBarButtons start--
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "text.justify")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return view
    }()
    
    let leftBarBtt: UILabel = {
        let view = UILabel()
        view.text = "default_user"
        return view
    }()
    /// -- NavBarButtons end--
    
    let collectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        view.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 650)
        view.minimumInteritemSpacing = 0
        view.minimumLineSpacing = 0
//        view.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKFullPostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty")
        view.register(VKFullPostCommentsCell.self, forCellWithReuseIdentifier: "comments")
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
    }
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// - NavBarButtons start --
        navigationItem.setRightBarButton(rightButton, animated: true)
        /// - NavBarButtons end --
        view.addSubview(collectionView)
        setupConstraints()
    }
}

//MARK: - EXTENTIONS


//MARK: ACTIONS

extension VKPhotoLibVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let emptyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty", for: indexPath)
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? VKFullPostHeader else { return emptyHeader }
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width, height: 650)
        
    }
    
}

extension VKPhotoLibVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comments", for: indexPath) as? VKFullPostCommentsCell else { return UICollectionViewCell(frame: .zero)  }
        return cell
        
    }

}

