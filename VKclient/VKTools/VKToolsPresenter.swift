//
//  VKToolsPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.11.2021.
//

import Foundation

protocol VKToolPresenterDelegate {
    func showScanScreen()
}

class VKToolsPresenter {
    
    weak var view: VKToolsVC?
    var delegate: VKToolPresenterDelegate?
    
    init(_ view: VKToolsVC, _ coordinator: VKToolPresenterDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKToolsPresenter: VKToolsDelegate {
    func scanBttnPressed() {
        delegate?.showScanScreen()
    }
}

