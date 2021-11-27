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
    
    weak var view: VKPhotoLibVC?
    var delegate: VKPhotoLibFlowDelegate?
  
    
    init(_ view: VKPhotoLibVC, _ coordinator: VKPhotoLibFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKPhotoLibPresenter: VKPhotoLibVCDelegate {
    func test() {
    }
}
