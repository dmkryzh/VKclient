//
//  StartPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation

class StartPresenter {
    
    weak var view: StartScreenVC?
    
    var delegate: StartFlowDelegate
    
    init(_ view: StartScreenVC, _ coordinator: StartFlowDelegate) {
        self.view = view
        self.delegate = coordinator
    }
    
}

extension StartPresenter: StartPresenterProtocol {
    
    func accountIsExistButtonPressed() {
        delegate.loginFlowChosen()
    }
    
    func registerButtonPressed() {
        delegate.registrationFlowChosen()
//        delegate.testPurposes()
//        delegate.testWithTabBar()
//        delegate.testMaterialTab()
    }
}
