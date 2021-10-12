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

protocol LoginDelegate {
    func loginIsSucceed()
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginVC?
    
    var delegate: LoginDelegate?
    
    func acceptButton() {
        delegate?.loginIsSucceed()
    }
    
    init(_ view: LoginVC, _ coordinator: LoginCoordinator) {
        self.view = view
        self.delegate = coordinator
    }
}

