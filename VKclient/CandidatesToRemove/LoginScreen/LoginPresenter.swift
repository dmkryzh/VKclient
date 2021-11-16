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

class LoginPresenter {
    
    weak var view: LoginVC?
    
    var delegate: LoginDelegate?

    init(_ view: LoginVC, _ coordinator: LoginCoordinator) {
        self.view = view
        self.delegate = coordinator
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    @objc func acceptButton() {
        delegate?.loginIsSucceed()
    }
}

