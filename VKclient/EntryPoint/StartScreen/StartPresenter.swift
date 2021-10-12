//
//  StartPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 11.10.2021.
//

import Foundation

@objc protocol StartPresenterProtocol {
    func registerButtonPressed()
    func accountIsExistButtonPressed()
}

protocol StartDelegate {
    func registrationFlowChosen()
    func loginFlowChosen()
}

class StartPresenter: StartPresenterProtocol {
    
    weak var view: StartScreenVC?
    
    var delegate: StartDelegate?
    
    @objc func registerButtonPressed() {
        delegate?.registrationFlowChosen()
    }
    
    @objc func accountIsExistButtonPressed() {
        delegate?.loginFlowChosen()
    }
    
    init(_ view: StartScreenVC, _ coordinator: StartDelegate) {
        self.view = view
        self.delegate = coordinator
    }
    
}
