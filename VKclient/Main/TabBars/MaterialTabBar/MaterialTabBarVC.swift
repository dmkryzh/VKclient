//
//  MaterialTabBarVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 17.11.2021.
//

import Foundation
import MaterialComponents.MaterialTabs_TabBarView
import UIKit
import SnapKit

class MaterialTabBarVC: UIView {
    
    private let tabBar = MDCTabBarView()
    
    func configureTabBarItems() {
        
        tabBar.items = [
          UITabBarItem(title: "Новости", image: nil, selectedImage: nil),
          UITabBarItem(title: "Для вас", image: nil, selectedImage: nil)
        ]
        
        tabBar.preferredLayoutStyle = .fixed
        tabBar.rippleColor = .clear
        tabBar.selectionIndicatorStrokeColor = UIColor(named: "bloodyRedColor")
        tabBar.selectedItem  = tabBar.items[0]
        tabBar.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        self.addSubview(tabBar)
    }
    
    func setupConstraints() {
   
        tabBar.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self)
            make.width.equalTo(200)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTabBarItems()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MaterialTabBarVC: MDCTabBarViewDelegate {
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {

    }
}
