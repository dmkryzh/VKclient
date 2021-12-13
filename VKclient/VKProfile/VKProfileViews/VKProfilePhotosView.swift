//
//  VKProfilePhotosView.swift
//  VKclient
//
//  Created by Dmitrii KRY on 13.12.2021.
//

import Foundation
import UIKit
import SnapKit

class VKProfilePhotosView: UICollectionViewCell {
    
    var dataDelegate: VKProfileDataDelegate?
    
    let collectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKHorisontalPicCell.self, forCellWithReuseIdentifier: "photoList")
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
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

extension VKProfilePhotosView: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 72, height: 72)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }

}

extension VKProfilePhotosView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataDelegate = self.dataDelegate else { return 0 }
        return dataDelegate.returnCellsCount(.photoLib)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        guard let dataDelegate = self.dataDelegate else { return UICollectionViewCell(frame: .zero) }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoList", for: indexPath) as? VKHorisontalPicCell else { return UICollectionViewCell(frame: .zero)  }
        
        cell.photoImage.layer.cornerRadius = 5
        
        if indexPath.item == dataDelegate.returnCellsCount(.photoLib) {
            let threeDots = UIImage(systemName: "arrow.right")
            cell.photoImage.image = threeDots
        } else {
            let photo = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .photoLib))
            cell.photoImage.image = photo
        }
        return cell
        
    }
}

