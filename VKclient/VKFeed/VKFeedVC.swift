//
//  VKFeedVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 17.10.2021.
//

import Foundation
import UIKit
import SnapKit
import Popover

protocol VKFeedDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}

protocol VKFeedPresenterDelegate {
    func menuPressed()
    func postSettingsPressed(_ sender: Any)
    func testSomeSettingIsChosen()
    func friendProfileFlowIsChosen()
}


final class VKFeedVC: UIViewController {
    
    let materialTabBar: MaterialTabBarVC = {
        let view = MaterialTabBarVC()
        return view
    }()
    
    let sliderTransitionDelegate = SliderPresentationManager()
    
    var presenter: VKFeedPresenterDelegate?
    
    var dataDelegate: VKFeedDataDelegate?
    
    /// -- NavBarButtons start--
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "bell.fill")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.tintColor = .black
        //        view.action = #selector(menuBttnHandler)
        //        view.target = self
        return view
    }()
    
    let leftBarBtt: UILabel = {
        let view = UILabel()
        view.text = "Лента"
        return view
    }()
    /// -- NavBarButtons end--
    
    let feedCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        view.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
        return view
    }()
    
    lazy var feedCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: feedCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKPostFeedCell.self, forCellWithReuseIdentifier: "VKFeedPosts")
        view.register(VKFeedStoriesView.self, forCellWithReuseIdentifier: "VKStories")
        view.register(VKPostSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty")
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
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        materialTabBar.snp.makeConstraints { make in
            make.top.trailing.equalTo(safe)
            make.leading.equalTo(safe).offset(16)
            make.height.equalTo(50)
        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(materialTabBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(safe)
        }
        
    }
    
    //MARK: - LIFECYCLE
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        ///to recalculate viewLayout for binding left and right sides of collectionView to superview edges
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// - NavBarButtons start --
        navigationItem.setRightBarButton(rightButton, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(), animated: false)
        navigationItem.leftBarButtonItem?.customView = leftBarBtt
        /// - NavBarButtons end --
        view.addSubviews(materialTabBar, feedCollectionView)
        setupConstraints()
    }
}

//MARK: - EXTENTIONS

extension VKFeedVC: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let emptyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "empty", for: indexPath)
        
        guard indexPath.section > 0 else { return emptyHeader }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? VKPostSectionHeader else { return emptyHeader }
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard section > 0 else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 120)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 300)
        }
    }
    
}

extension VKFeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dataDelegate = self.dataDelegate else { return 0 }
        guard section > 0 else { return 1 }
        return dataDelegate.returnCellsCount(.profileText)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataDelegate = self.dataDelegate else { return UICollectionViewCell(frame: .zero) }
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKStories", for: indexPath) as? VKFeedStoriesView else { return UICollectionViewCell(frame: .zero)  }
            cell.dataDelegate = dataDelegate
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKFeedPosts", for: indexPath) as? VKPostFeedCell else { return UICollectionViewCell(frame: .zero)  }
            cell.contentView.isUserInteractionEnabled = false
            cell.postTextAndImage.postText.text = dataDelegate.returnDataForCell(indexPath.item, .profileText)
            cell.postTextAndImage.postPhoto.image = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .profilePhoto))
            cell.additionalInfo.addTarget(self, action: #selector(postSettingsHandler(_:)), for: .touchUpInside)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(avaIsTapped))
            cell.ava.addGestureRecognizer(gesture)
            cell.ava.isUserInteractionEnabled = true
            return cell
        }
        
    }
}

extension VKFeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.testSomeSettingIsChosen()
        self.popOver.dismiss()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension VKFeedVC: UITableViewDataSource {
    
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

extension VKFeedVC {
    @objc func postSettingsHandler(_ sender: Any) {
        presenter?.postSettingsPressed(sender)
    }
    
    @objc func menuBttnHandler() {
        presenter?.menuPressed()
    }
    
    @objc func avaIsTapped() {
        presenter?.friendProfileFlowIsChosen()
        print("!!!!!!!!!!!!!!!")
    }
}


