//
//  VKCollectionVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import SnapKit
import UIKit
import SwiftUI

protocol VKCollectionPresenterDelegate {
}

protocol VKCollectionFlowDelegate {
}

protocol VKCollectionDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}

final class VKCollectionVC: UIViewController {
    
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
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(VKCollectionPost.self, forCellReuseIdentifier: "postFeed")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var isCurrentUser = true
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        tableView.snp.makeConstraints { make in
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
        view.addSubview(tableView)
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.invalidateIntrinsicContentSize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}

//MARK: - EXTENTIONS

extension VKCollectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(cell.frame.height)
    }
    
}

extension VKCollectionVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataDelegate = self.dataDelegate else { return 0 }
        return dataDelegate.returnCellsCount(.profileText)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataDelegate = self.dataDelegate else { return UITableViewCell(frame: .zero) }
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postFeed", for: indexPath) as? VKCollectionPost else { return UITableViewCell(frame: .zero)  }
            cell.contentView.isUserInteractionEnabled = false
            cell.postTextAndImage.postText.text = dataDelegate.returnDataForCell(indexPath.item, .profileText)
            cell.postTextAndImage.postPhoto.image = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .profilePhoto))
            cell.additionalInfo.addTarget(self, action: #selector(postSettingsHandler(_:)), for: .touchUpInside)
            return cell
    }
    
}


//MARK: ACTIONS

extension VKCollectionVC {
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

