//
//  VKGeneralInfoPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//

import Foundation

protocol VKGeneralInfoFlowDelegate {
    func test()
    func dismissVC()
}

class VKGeneralInfoPresenter {
    
    var view: VKGeneralInfoVC?
    
    var delegate: VKGeneralInfoFlowDelegate?
    
    init(_ view: VKGeneralInfoVC, _ coordinator: VKGeneralInfoFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKGeneralInfoPresenter: VKGeneralInfoVCDelegate {
    func closeVC() {
        delegate?.dismissVC()
    }
    
    func test() {
        delegate?.test()
    }

}
