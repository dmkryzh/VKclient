//
//  LoginVkModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation

struct LoginVkModel: LoginPresenterDataDelegate {
    
    var webURL = URL(string: "https://oauth.vk.com/authorize?client_id=7975663&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=notify,friends,photos,audio,video,status,wall,groups,email&response_type=token")
    
    var token: String? {
        didSet {
            guard let token = token else { return }
            print("token inside the model: \(token)")
        }
    }
}
