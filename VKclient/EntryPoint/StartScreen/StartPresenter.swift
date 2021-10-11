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

class StartPresenter: StartPresenterProtocol {
    
    weak var view: StartScreenVC?
    
    weak var coordinator: StartCoordinator?
    
    @objc func registerButtonPressed() {
        coordinator?.register()
    }
    
    @objc func accountIsExistButtonPressed() {
        coordinator?.accIsExist()
    }
    
    init(_ view: StartScreenVC, _ coordinator: StartCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
}
