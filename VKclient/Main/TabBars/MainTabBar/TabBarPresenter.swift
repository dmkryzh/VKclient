//
//  TabBarPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 08.11.2021.
//
import Foundation

class TabBarPresenter {
    
    weak var view: TabBarMain?
    
    var delegate: TabBarMainCoordinator?
    
    init(_ view: TabBarMain, _ coordinator: TabBarMainCoordinator) {
        self.view = view
        delegate = coordinator
    }
}

extension TabBarPresenter: TabBarPresenterDelegate {
    func middleButtonIsTapped() {
        delegate?.profileFlowIsChosen()
    }
}
