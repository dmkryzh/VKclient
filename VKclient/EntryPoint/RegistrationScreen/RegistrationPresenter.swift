//
//  RegistrationPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation

@objc protocol RegPresenterProtocol {
    func nextButtonPressed()
}

class RegistrationPresenter: RegPresenterProtocol {
    
    weak var view: RegistrationVC?
    
    var coordinator: RegistrationCoordinator?
    
    @objc func nextButtonPressed() {
        coordinator?.startConfirmation()
    }
    
    init(_ view: RegistrationVC, _ coordinator: RegistrationCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
