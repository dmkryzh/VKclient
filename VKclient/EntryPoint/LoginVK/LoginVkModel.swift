//
//  LoginVkModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation

protocol LoginVkModelProtocol {
    var token: String? { get set }
}

struct LoginVkModel: LoginVkModelProtocol {
    var token: String? {
        didSet {
            guard let token = token else { return }
            print("token inside the model: \(token)")
        }
    }
}
