//
//  VKFullPostSettingsPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation

protocol VKFullPostSettingsFlowDelegate {
    func test()
}

class VKFullPostSettingsPresenter {
    
    weak var view: VKFullPostSettingsVC?
    
    var delegate: VKFullPostSettingsFlowDelegate?
    
    init(_ view: VKFullPostSettingsVC, _ coordinator: VKFullPostSettingsFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKFullPostSettingsPresenter: VKFullPostSettingsDelegate {
    func test() {
    }
}


