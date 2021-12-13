//
//  VKProfileVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit
import SnapKit
import Popover

protocol VKProfilePresenterDelegate {
    func menuPressed()
    func postSettingsPressed(_ sender: Any)
    func postIsPressed()
    func photoArrowIsPressed()
    func editBttnIsPressed()
}

protocol VKProfileFlowDelegate {
    func settingsFlowIsChosen()
    func postSettingsIsChosen(_ sender: Any)
    func postFullViewIsChosen()
    func photoFlowIsChosen()
    func editFlowIsChosen()
}

protocol VKProfileDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}


final class VKProfileVC: UIViewController {
    
    let sliderTransitionDelegate = SliderPresentationManager(.right)
    
    var presenter: VKProfilePresenterDelegate?
    
    var dataDelegate: VKProfileDataDelegate?
 
    /// -- NavBarButtons start--
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "text.justify")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.action = #selector(menuBttnHandler)
        view.target = self
        return view
    }()
    
    let leftBarBtt: UILabel = {
        let view = UILabel()
        view.text = "default_user"
        return view
    }()
    /// -- NavBarButtons end--
    
    let vkProfileLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        view.minimumInteritemSpacing = 10
        view.minimumLineSpacing = 10
        return view
    }()
    
    lazy var vkProfileCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: vkProfileLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        view.register(VKProfilePhotosHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "photoHeader")
        view.register(VKProfilePostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "feedHeader")
        view.register(VKProfilePhotosView.self, forCellWithReuseIdentifier: "photoLib")
        view.register(VKPostFeedCell.self, forCellWithReuseIdentifier: "postFeed")
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    //MARK: Popover
    let popOver: Popover = {
        let options: [PopoverOption] = [.type(.left), .cornerRadius(10), .showBlackOverlay(false) ]
        let view = Popover(options: options)
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
        view.layer.shouldRasterize = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 350, height: 260))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()
    
    var isCurrentUser = true
    
    func friendProfile() {
        isCurrentUser.toggle()
        vkProfileLayout.invalidateLayout()
    }
    
    
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        vkProfileCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// - NavBarButtons start --
        navigationItem.setRightBarButton(rightButton, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(), animated: false)
        navigationItem.leftBarButtonItem?.customView = leftBarBtt
        /// - NavBarButtons end --
        view.addSubview(vkProfileCollectionView)
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        vkProfileLayout.invalidateLayout()
    }
}

//MARK: - EXTENTIONS

extension VKProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.postIsPressed()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
 
        let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

            // Use this view to calculate the optimal size based on the collection view's width
            let headerSize = headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required, // Width is fixed
                                                      verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
        return headerSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch indexPath.section {
        case 0:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? VKProfileHeaderView else { return UICollectionReusableView(frame: .zero)}
            if !isCurrentUser {
            headerView.altStackBtts.isHidden = false
            headerView.editBtt.isHidden = true
            headerView.stackBttsSec.isHidden = true
            headerView.updateView()
            }
            return headerView
        case 1:
            guard let photoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "photoHeader", for: indexPath) as? VKProfilePhotosHeader else { return UICollectionReusableView(frame: .zero)}
            photoHeader.photoLibArrow.addTarget(self, action: #selector(photoHandler), for: .touchUpInside)
            return photoHeader
        case 2:
            guard let feedHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "feedHeader", for: indexPath) as? VKProfilePostHeader else { return UICollectionReusableView(frame: .zero)}
            
            if !isCurrentUser {
            feedHeader.myPostsLabel.text = "Default user посты"
            }
            return feedHeader
        default:
            return UICollectionReusableView(frame: .zero)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 1:
            return CGSize(width: collectionView.frame.width, height: 120)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 300)
        default:
            return .zero
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension VKProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dataDelegate = self.dataDelegate else { return 0 }
        
        switch section {
        case 1:
            return 1
        case 2:
            return dataDelegate.returnCellsCount(.profileText)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataDelegate = self.dataDelegate else { return UICollectionViewCell(frame: .zero) }
        
        switch indexPath.section {
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoLib", for: indexPath) as? VKProfilePhotosView else { return UICollectionViewCell(frame: .zero)  }
            cell.dataDelegate = dataDelegate
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postFeed", for: indexPath) as? VKPostFeedCell else { return UICollectionViewCell(frame: .zero)  }
            cell.contentView.isUserInteractionEnabled = false
            cell.postTextAndImage.postText.text = dataDelegate.returnDataForCell(indexPath.item, .profileText)
            cell.postTextAndImage.postPhoto.image = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .profilePhoto))
            cell.additionalInfo.addTarget(self, action: #selector(postSettingsHandler(_:)), for: .touchUpInside)
            return cell
            
        default:
            return UICollectionViewCell(frame: .zero)
    
        }
    }
}

extension VKProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.popOver.dismiss()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension VKProfileVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let dataDelegate = self.dataDelegate else { return 0 }
        return dataDelegate.returnCellsCount(.postSettings)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataDelegate = self.dataDelegate else { return UITableViewCell(frame: .zero) }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dataDelegate.returnDataForCell(indexPath.item, .postSettings)
        return cell
    }
}

//MARK: ACTIONS

extension VKProfileVC {
    @objc func postSettingsHandler(_ sender: Any) {
        presenter?.postSettingsPressed(sender)
    }
    
    @objc func menuBttnHandler() {
        presenter?.menuPressed()
    }
    
    @objc func photoHandler() {
        presenter?.photoArrowIsPressed()
    }
    
    @objc func editHandler() {
        presenter?.editBttnIsPressed()
    }
}
