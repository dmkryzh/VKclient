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

protocol VKPhotolibDataDelegate {
    func returnCellsCount(_ dataType: PhotoDataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: PhotoDataType) -> String
}

final class VKPhotoLibVC: UIViewController {
    
    var model: VKPhotolibDataDelegate?
    
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
        view.minimumInteritemSpacing = 5
        view.minimumLineSpacing = 5
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(VKOnePhotoCell.self, forCellWithReuseIdentifier: "photo")
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty")
        view.register(VKPhotoFolderHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "folderHeader")
        view.register(VKPhotoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "photoHeader")
        return view
    }()
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safe).offset(10)
            make.leading.equalTo(safe).offset(16)
            make.trailing.equalTo(safe).inset(16)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let emptyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty", for: indexPath)

        if indexPath.section == 0 {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "folderHeader", for: indexPath) as? VKPhotoFolderHeader else { return emptyHeader }
        return headerView
            
        } else {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "photoHeader", for: indexPath) as? VKPhotoHeader else { return emptyHeader }
            return headerView
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width / 3 - 5
        let cellHeight: CGFloat = 110
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }


}

extension VKPhotoLibVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let model = model else { return 0 }
        
        if section > 0 {
        
            return model.returnCellsCount(.photo)
        } else {
            return model.returnCellsCount(.folder)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = model else { return UICollectionViewCell(frame: .zero) }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as? VKOnePhotoCell else { return  UICollectionViewCell(frame: .zero) }
        
        
        if indexPath.section == 0 {
            let image = UIImage(named: model.returnDataForCell(indexPath.item, .folder))
            cell.photoImage.image = image
            return cell
        } else {

            let image = UIImage(named: model.returnDataForCell(indexPath.item, .photo))
        cell.photoImage.image = image
        return cell
        }
    }

}

