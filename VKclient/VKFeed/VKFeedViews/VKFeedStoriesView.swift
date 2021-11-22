//
//  VKFeedStoriesView.swift
//  VKclient
//
//  Created by Dmitrii KRY on 17.11.2021.
//

import Foundation
import UIKit
import SnapKit

class VKFeedStoriesView: UICollectionViewCell {
    
    var dataDelegate: VKFeedDataDelegate?
    
    var selectedItemIndex: Int?
    
    let storiesCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        return view
    }()
    
    lazy var storiesCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: storiesCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKHorisontalPicCell.self, forCellWithReuseIdentifier: "VKStories")
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    func setupConstraints() {
        storiesCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    /// - cell handler allows to handle ceelView depends on its status - selected or regular one. We can use it for selection\deselection logic and for cell creation logic
    func cellHandler(_ item: IndexPath, _ isSelected: Bool, _ collection: UICollectionView? = nil, _ cell: UICollectionViewCell? = nil) {
        
        var viewCell: UICollectionViewCell?
        
        if let cellIsCreated = cell {
            viewCell = cellIsCreated
        } else {
            viewCell = collection?.cellForItem(at: item)
        }
        
        guard let cell = viewCell else { return }
        
        guard isSelected else {
            for sub in cell.subviews {
                if sub is UIImageView {
                    sub.removeFromSuperview()
                }
                sub.layer.borderWidth = 0
            }
            return
        }
        
        let image = UIImage(systemName: "circle.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        cell.addSubview(imageView)
        
        for sub in cell.subviews {
            if sub is UIImageView {
                cell.bringSubviewToFront(sub)
                sub.frame = CGRect(x: 50, y: 50, width: 20, height: 20)
            }
            sub.layer.borderWidth = 2
            sub.layer.cornerRadius = 36
            sub.layer.borderColor = UIColor(named: "bloodyRedColor")?.cgColor
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(storiesCollectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extensions

extension VKFeedStoriesView: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 72, height: 72)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItemIndex = indexPath.item
        cellHandler(indexPath, true, collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        cellHandler(indexPath, false, collectionView)
    }
}

extension VKFeedStoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataDelegate = self.dataDelegate else { return 0 }
        return dataDelegate.returnCellsCount(.photoLib)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        guard let dataDelegate = self.dataDelegate else { return UICollectionViewCell(frame: .zero) }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKStories", for: indexPath) as? VKHorisontalPicCell else { return UICollectionViewCell(frame: .zero)  }
        
        cell.photoImage.layer.cornerRadius = 36
        let photo = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .photoLib))
        cell.photoImage.image = photo
        
        /// - checkign if cell is selected
        if indexPath.item == selectedItemIndex {
            cellHandler(indexPath, true, nil, cell)
        } else {
            cellHandler(indexPath, false, nil, cell)
        }

        return cell
        
    }
}

