//
//  LoginVkPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation

protocol LoginVkPresenterProtocol {
    func loggedIn(_ link: String, _ completion: ((String) -> String)?)
}

protocol LoginVkDelegate {
    func startFeedFlow()
    func startProfileFlow()
}

class LoginVkPresenter: LoginVkPresenterProtocol {
    
    weak var view: LoginVkVC?
    
    var delegate: LoginVkDelegate?
    
    var model: LoginVkModelProtocol?
    
    func loggedIn(_ link: String, _ completion: ((String) -> String)?) {
        let test = "access_token"
        if (link.range(of: test) != nil) {
            guard let completion = completion else { return }
            model?.token = completion(link)
            delegate?.startProfileFlow()
        }
    }
    
    init(_ model: LoginVkModelProtocol, _ view: LoginVkVC, _ coordinator: LoginVkDelegate) {
        self.model = model
        self.view = view
        delegate = coordinator
    }
}
