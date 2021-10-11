//
//  LoginPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation

@objc protocol LoginPresenterProtocol {
    func acceptButton()
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginVC?
    
    var coordinator: LoginCoordinator?
    
    func acceptButton() {
        coordinator?.start()
    }
    
    init(_ view: LoginVC, _ coordinator: LoginCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
