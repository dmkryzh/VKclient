//
//  LoginVkPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation

protocol LoginPresenterDataDelegate {
    var token: String? { get set }
    var webURL: URL? { get set }
}

protocol LoginVkPresenterDelegate {
    func test()
    func startProfileFlow()
}

class LoginVkPresenter: LoginVkDelegate {
    
    lazy var linkForWebView = model.webURL
    
    weak var view: LoginVkVC?
    
    var delegate: LoginVkPresenterDelegate?
    
    var model: LoginPresenterDataDelegate
    
    var apiDelegate: APIClient
    
    func loggedIn(_ link: String, _ completion: ((String) -> String)?) {
        let test = "access_token"
        if (link.range(of: test) != nil) {
            guard let completion = completion else { return }
            model.token = completion(link)
            let api = APIClient(model)
            let _ = api.updateToken()
            api.getRequest(api.parametersForFeed, nil, "https://api.vk.com/method/newsfeed.get")
            delegate?.startProfileFlow()
        }
    }
    
    init(_ model: LoginPresenterDataDelegate, _ view: LoginVkVC, _ coordinator: LoginVkPresenterDelegate, _ api: APIClient) {
        self.model = model
        self.view = view
        delegate = coordinator
        apiDelegate = api
    }
}
