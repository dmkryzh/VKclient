//
//  VKProfilePresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation

protocol VKProfilePresenterProtocol {
}

protocol VKProfileDelegate {
}

class VKProfilePresenter: VKProfilePresenterProtocol {
    
    weak var view: VKProfileVC?
    
    var delegate: VKProfileDelegate?
    
    var model: VKProfileModel?
    
    init(_ model: VKProfileModel, _ view: VKProfileVC, _ coordinator: VKProfileDelegate) {
        self.model = model
        self.view = view
        delegate = coordinator
    }
}

