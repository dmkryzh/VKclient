//
//  VKProfileOptionsPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation

protocol VKProfileOptionsFlowDelegate {
    func generalInfoIsChosen()
}

class VKProfileOptionsPresenter {
    
    var view: VKProfileOptionsVC?
    
    var delegate: VKProfileOptionsFlowDelegate?
    
    init(_ view: VKProfileOptionsVC, _ coordinator: VKProfileOptionsFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKProfileOptionsPresenter: VKProfileOptionsDelegate {
    func generalInfoIsTapped() {
        delegate?.generalInfoIsChosen()
    }
}
