//
//  VKProfileOptionsPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 25.10.2021.
//

import Foundation

protocol VKProfileOptionsPresenterProtocol {
}

protocol VKProfileOptionsDelegate {
}

class VKProfileOptionsPresenter: VKProfileOptionsPresenterProtocol {
    
    weak var view: VKProfileOptionsVC?
    
    var delegate: VKProfileOptionsDelegate?
    
    init(_ view: VKProfileOptionsVC, _ coordinator: VKProfileOptionsDelegate) {
        self.view = view
        delegate = coordinator
    }
}
