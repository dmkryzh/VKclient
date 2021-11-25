//
//  VKFullPostPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 18.11.2021.
//

import Foundation

protocol VKFullPostFlowDelegate {
    func navigateToSomewhere()
}

class VKFullPostPresenter {
    
    weak var view: VKFullPostVC?
    var delegate: VKFullPostFlowDelegate?
  
    
    init(_ view: VKFullPostVC, _ coordinator: VKFullPostFlowDelegate) {
        self.view = view
        delegate = coordinator
    }
}

extension VKFullPostPresenter: VKFullPostPresenterDelegate {
    func test() {
    } 
}


