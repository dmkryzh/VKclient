//
//  VKProfileEditPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation

protocol VKProfileEditFlowDelegate {
    func test()
}

class VKProfileEditPresenter {
    
    weak var view: VKProfileEditVC?
    
    var delegate: VKProfileEditFlowDelegate?
    
    init(_ view: VKProfileEditVC, _ coordinator: VKProfileEditFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKProfileEditPresenter: VKProfileEditVCDelegate {
    func test() {
    }
}
