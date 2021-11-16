//
//  ConfirmationPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation

@objc protocol ConfPresenterProtocol {
    func registerButtonPressed()
}

protocol ConfDelegate {
    func userIsRegistered()
}

class ConfirmationPresenter: ConfPresenterProtocol {
    
    func registerButtonPressed() {
        
    }
    
    let passedNumber = "+7300500"
    
    weak var view: ConfirmationVC?
    
    var coordinator: ConfirmationCoordinator?
 
    init(_ view: ConfirmationVC, _ coordinator: ConfirmationCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
