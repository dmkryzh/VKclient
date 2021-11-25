//
//  VKFullPostCommentsCell.swift
//  VKclient
//
//  Created by Dmitrii KRY on 24.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKFullPostCommentsCell: UICollectionViewCell {
    
    var selectedItemIndex: Int?
    
    let collectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.minimumInteritemSpacing = 0
        view.minimumLineSpacing = 0
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKFullPostCommentView.self, forCellWithReuseIdentifier: "comment")
        view.backgroundColor = .clear
        return view
    }()
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extensions

extension VKFullPostCommentsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension VKFullPostCommentsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comment", for: indexPath) as? VKFullPostCommentView else { return UICollectionViewCell(frame: .zero)  }
        return cell
        
    }
}
