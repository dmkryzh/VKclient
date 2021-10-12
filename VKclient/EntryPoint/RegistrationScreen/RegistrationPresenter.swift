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

protocol RegistrationDelegate {
    func numberIsPassed()
}

class RegistrationPresenter: RegPresenterProtocol {
    
    weak var view: RegistrationVC?
    
    var delegate: RegistrationDelegate?
    
    @objc func nextButtonPressed() {
        delegate?.numberIsPassed()
    }
    
    init(_ view: RegistrationVC, _ coordinator: RegistrationDelegate) {
        self.view = view
        self.delegate = coordinator
    }
}
