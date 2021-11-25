//
//  VKPhotoLibAlbumCell.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKPhotoLibAlbumCell: UICollectionViewCell {
    
    let commentLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        return view
    }()
    
    lazy var commentView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: commentLayout)
        view.dataSource = self
        view.delegate = self
        
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        
        view.register(VKFullPostCommentHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
  
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty")
        
        view.register(VKFullPostCommentReply.self, forCellWithReuseIdentifier: "reply")
        return view
    }()
    
    func setupConstraints() {
        commentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(commentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extensions

extension VKPhotoLibAlbumCell: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width, height: 60)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                
        let emptyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty", for: indexPath)
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? VKFullPostCommentHeader else { return emptyHeader }
        return headerView
        
    }

}

extension VKPhotoLibAlbumCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reply", for: indexPath) as? VKFullPostCommentReply else { return UICollectionViewCell(frame: .zero)  }
        return cell
        
    }
    
}


