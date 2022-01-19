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
import pop

protocol VKCollectionPresenterDelegate {
}

protocol VKCollectionFlowDelegate {
}

protocol VKCollectionDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}

final class VKCollectionVC: UIViewController {
    
    var shownIndeces = [IndexPath]()
    
    var cellHeight = [CGFloat]()  {
        didSet {
            getAnchor()
        }
    }
    
    func getAnchor() {
        (0..<cellHeight.count).forEach {
            let totalInset = tableView.adjustedContentInset.top
            let offset = cellHeight.prefix($0).reduce(0, +)
            anchors.append(CGPoint(x: 0, y: offset - totalInset))
        }
    }
    
//    lazy var anchors: [CGPoint] = (0..<cellHeight.count).map {
//        let totalInset = tableView.adjustedContentInset.top
//        let offset = cellHeight.prefix($0).reduce(0, +)
//        return CGPoint(x: 0, y: offset - totalInset)
//    }
    
    var anchors = [CGPoint]()
    
    var maxAnchor: CGPoint {
        let inset = tableView.adjustedContentInset.bottom
        return CGPoint(x: 0, y: tableView.contentSize.height - view.bounds.height + inset)
    }
    
    func nearestAnchor(forContentOffset offset: CGPoint) -> CGPoint {
        var candidate = anchors.min(by: { abs($0.y - offset.y) < abs($1.y - offset.y) })!
        candidate.y = min(candidate.y, maxAnchor.y)
        return candidate
    }
    
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
        print("-----\(tableView.contentSize.height)------")
        
    }
    
}

//MARK: - EXTENTIONS

extension VKCollectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //adding cell heights only for unique indexes
        guard !shownIndeces.contains(indexPath) else { return }
        shownIndeces.append(indexPath)
        cellHeight.append(round(cell.frame.height))
    }
    
}

extension VKCollectionVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
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

extension FloatingPoint {
    
    func project(initialVelocity: Self, decelerationRate: Self) -> Self {
        if decelerationRate >= 1 {
            assert(false)
            return self
        }
        return self + initialVelocity * decelerationRate / (1 - decelerationRate)
    }
    
}

extension CGPoint {
    
    func project(initialVelocity: CGPoint, decelerationRate: CGPoint) -> CGPoint {
        let xProjection = x.project(initialVelocity: initialVelocity.x, decelerationRate: decelerationRate.x)
        let yProjection = y.project(initialVelocity: initialVelocity.y, decelerationRate: decelerationRate.y)
        return CGPoint(x: xProjection, y: yProjection)
    }
    
    func project(initialVelocity: CGPoint, decelerationRate: CGFloat) -> CGPoint {
        return project(initialVelocity: initialVelocity, decelerationRate: CGPoint(x: decelerationRate, y: decelerationRate))
    }
    
}

extension VKCollectionVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let decelerationRate = UIScrollView.DecelerationRate.normal.rawValue
        let offsetProjection = scrollView.contentOffset.project(initialVelocity: velocity, decelerationRate: decelerationRate)
        let targetAnchor = nearestAnchor(forContentOffset: offsetProjection)
        
        // Stop system animation
        targetContentOffset.pointee = scrollView.contentOffset
        
        scrollView.snapAnimated(toContentOffset: targetAnchor, velocity: velocity)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.stopSnappingAnimation()
    }
}

extension UIScrollView {
    
    private static let snappingAnimationKey = "CustomPaging.scrollView.snappingAnimation"
    
    func snapAnimated(toContentOffset newOffset: CGPoint, velocity: CGPoint) {
        let animation: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPScrollViewContentOffset)
        animation.velocity = velocity
        animation.toValue = newOffset
        animation.fromValue = contentOffset
        pop_add(animation, forKey: UIScrollView.snappingAnimationKey)
    }
    
    func stopSnappingAnimation() {
        pop_removeAnimation(forKey: UIScrollView.snappingAnimationKey)
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
