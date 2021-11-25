//
//  VKPhotoLibPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.10.2021.
//

import Foundation

protocol VKPhotoLibFlowDelegate {
    func navigateToSomewhere()
}

class VKPhotoLibPresenter {
    
    weak var view: VKFullPostVC?
    var delegate: VKFullPostFlowDelegate?
  
    
    init(_ view: VKFullPostVC, _ coordinator: VKFullPostFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKPhotoLibPresenter: VKPhotoLibVCDelegate {
    func test() {
    }
}
