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
}

protocol VKProfileFlowDelegate {
    func settingsFlowIsChosen()
    func postSettingsIsChosen(_ sender: Any)
    func postFullViewIsChosen()
    func photoFlowIsChosen()
}

protocol VKProfileDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}


final class VKProfileVC: UIViewController {
    
    let sliderTransitionDelegate = SliderPresentationManager(.right)
    
    var presenter: VKProfilePresenterDelegate?
    
    var dataDelegate: VKProfileDataDelegate?
    
    ///postCollectionView height logic
    private var height: CGFloat = 0  {
        didSet {
            postsCollectionView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let ava: UIImageView = {
        let image = UIImage(named: "pepe")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let userName: UILabel = {
        let view = UILabel()
        view.text = "Default User"
        return view
    }()
    
    let userNameSubtitle: UILabel = {
        let view = UILabel()
        view.text = "developer"
        return view
    }()
    
    let detailSubtitle: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Detailed information", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let exclamationMark: UIImageView = {
        let image = UIImage(systemName: "exclamationmark.circle.fill")
        let view = UIImageView(image: image)
        view.tintColor = UIColor(named: "deepBlueColor")
        return view
    }()
    
    let editBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Редактировать", for: .normal)
        view.backgroundColor = UIColor(named: "bloodyRedColor")
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var postsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nпубликаций", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var subscriptionsBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписок", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var followersBtt: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("XXX\nподписчиков", for: .normal)
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var stackBtts: UIStackView = {
        let view = UIStackView(arrangedSubviews: [postsBtt, subscriptionsBtt, followersBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 25
        return view
    }()
    
    let line: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        return view
    }()
    
    let createPostBtt: UIButton = {
        let image = UIImage(systemName: "pencil.circle")
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.setTitle("Запись", for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createStoryBtt: UIButton = {
        let image = UIImage(systemName: "livephoto")
        let view = UIButton(type: .system)
        view.setTitle("История", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let createPhotoBtt: UIButton = {
        let image = UIImage(systemName: "camera.circle")
        let view = UIButton(type: .system)
        view.setTitle("Фото", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    lazy var stackBttsSec: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createPostBtt, createStoryBtt, createPhotoBtt])
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 60
        return view
    }()
    
    let storiesCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        return view
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: storiesCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKHorisontalPicCell.self, forCellWithReuseIdentifier: "VKProfilePhotoLib")
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let photoLibLabel: UILabel = {
        let view = UILabel()
        view.text = "Фотографии XX"
        view.textColor = .label
        return view
    }()
    
    let photoLibArrow: UIButton = {
        let arrowConfig = UIImage.SymbolConfiguration(textStyle: .title3)
        let image = UIImage(systemName: "chevron.forward", withConfiguration: arrowConfig)
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(photoHandler), for: .touchUpInside)
        return view
    }()
    
    let myPostsLabel: UILabel = {
        let view = UILabel()
        view.text = "Мои посты"
        view.textColor = .label
        return view
    }()
    
    let searchPosts: UIButton = {
        let arrowConfig = UIImage.SymbolConfiguration(textStyle: .title3)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: arrowConfig)
        let view = UIButton(type: .system)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        return view
    }()
    
    
    let postsCollectionLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .vertical
        view.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
        return view
    }()
    
    lazy var postsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: postsCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(VKPostFeedCell.self, forCellWithReuseIdentifier: "VKProfilePostFeed")
        view.register(VKPostSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
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
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safe)
        }
        
        ava.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(containerView.snp.top).offset(15)
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        userName.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(250)
            make.top.equalTo(containerView).offset(20)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        userNameSubtitle.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(100)
            make.top.equalTo(userName.snp.bottom).offset(3)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        exclamationMark.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(ava.snp.trailing).offset(10)
        }
        
        detailSubtitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(140)
            make.top.equalTo(userNameSubtitle.snp.bottom).offset(5)
            make.leading.equalTo(exclamationMark.snp.trailing).offset(5)
        }
        
        editBtt.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
            make.top.equalTo(detailSubtitle.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        stackBtts.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(editBtt.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(400)
            make.top.equalTo(stackBtts.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        stackBttsSec.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(350)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        photoLibLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.top.equalTo(stackBttsSec.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }
        
        photoLibArrow.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(15)
            make.trailing.equalTo(containerView).inset(16)
            make.centerY.equalTo(photoLibLabel.snp.centerY)
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.height.equalTo(68)
            make.top.equalTo(photoLibLabel.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView)
        }
        
        myPostsLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(150)
            make.top.equalTo(photosCollectionView.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(16)
        }
        
        searchPosts.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.trailing.equalTo(containerView).inset(16)
            make.centerY.equalTo(myPostsLabel.snp.centerY)
        }
        
        postsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myPostsLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(containerView)
            ///to make collection view contenet a part of superview content, need to define initial height to 0
            make.height.equalTo(0)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
    }
    
    //MARK: - LIFECYCLE
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        ///to recalculate viewLayout for binding left and right sides of collectionView to superview edges
        postsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        /// - NavBarButtons start --
        navigationItem.setRightBarButton(rightButton, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(), animated: false)
        navigationItem.leftBarButtonItem?.customView = leftBarBtt
        /// - NavBarButtons end --
        view.addSubview(scrollView)
        scrollView.addSubviews(containerView, ava, userName, userNameSubtitle, exclamationMark, detailSubtitle, editBtt, stackBtts, line, stackBttsSec, photoLibLabel, photoLibArrow, photosCollectionView, myPostsLabel, searchPosts, postsCollectionView)
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createPostBtt.alignImageAndTitleVertically()
        createPhotoBtt.alignImageAndTitleVertically()
        createStoryBtt.alignImageAndTitleVertically()
        
        ///save collectionView contentSize to variable, where view height will be recalculated
        height = postsCollectionView.contentSize.height
        print(height)
    }
}

//MARK: - EXTENTIONS

extension VKProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.postIsPressed()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == postsCollectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? VKPostSectionHeader else { return UICollectionReusableView(frame: .zero)}
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == photosCollectionView {
            return CGSize(width: 72, height: 68)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == photosCollectionView {
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
        
        if collectionView == photosCollectionView {
            //            return VKPhotoLibModel.photosForTesting.count + 1
            /// +1 is added to handle arrow image which allows to navigate to PhotoLibrary VC
            return dataDelegate.returnCellsCount(.photoLib) + 1
        }
        else {
            return dataDelegate.returnCellsCount(.profileText)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataDelegate = self.dataDelegate else { return UICollectionViewCell(frame: .zero) }
        
        if collectionView == photosCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKProfilePhotoLib", for: indexPath) as? VKHorisontalPicCell else { return UICollectionViewCell(frame: .zero)  }
            
            cell.photoImage.layer.cornerRadius = 5
            
            if indexPath.item == dataDelegate.returnCellsCount(.photoLib) {
                let threeDots = UIImage(systemName: "arrow.right")
                cell.photoImage.image = threeDots
            } else {
                let photo = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .photoLib))
                cell.photoImage.image = photo
            }
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VKProfilePostFeed", for: indexPath) as? VKPostFeedCell else { return UICollectionViewCell(frame: .zero)  }
            cell.contentView.isUserInteractionEnabled = false
            cell.postTextAndImage.postText.text = dataDelegate.returnDataForCell(indexPath.item, .profileText)
            cell.postTextAndImage.postPhoto.image = UIImage(named: dataDelegate.returnDataForCell(indexPath.item, .profilePhoto))
            cell.additionalInfo.addTarget(self, action: #selector(postSettingsHandler(_:)), for: .touchUpInside)
            return cell
            
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
}
