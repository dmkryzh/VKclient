//
//  VKProfilePresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation

enum DataType {
    case profileText
    case profilePhoto
    case photoLib
}

@objc protocol VKProfilePresenterProtocol {
    func menuPressed()
    func postSettingsPressed()
}

protocol VKProfileDelegate {
    func settingsFlowIsChosen()
    func postSettingsIsChosen()
}

protocol VKProfileModelDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String
}

class VKProfilePresenter {
    
    weak var view: VKProfileVC?
    
    var delegate: VKProfileDelegate?
    
    var modelPost: VKProfileModel?
    
    var modelPhotoLib: VKPhotoLibModel?
    
    init(_ modelPost: VKProfileModel, modelPhotoLib: VKPhotoLibModel, _ view: VKProfileVC, _ coordinator: VKProfileDelegate) {
        self.modelPost = modelPost
        self.modelPhotoLib = modelPhotoLib
        self.view = view
        delegate = coordinator
    }
}

extension VKProfilePresenter: VKProfilePresenterProtocol {
    @objc func postSettingsPressed() {
        delegate?.postSettingsIsChosen()
    }
    

    @objc func menuPressed() {
        delegate?.settingsFlowIsChosen()
    }
}

extension VKProfilePresenter: VKProfileModelDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int{
        switch dataType {
        case.profileText:
            guard let model = self.modelPost else { return 0 }
            return model.photoPost.count
        case.photoLib:
            guard let model = self.modelPhotoLib else { return 0 }
            return model.photosForTesting.count
        default:
            return 0
        }
    }
    
    func returnDataForCell(_ item: Int, _ dataType: DataType) -> String {
        switch dataType {
        case .profileText:
            guard let model = self.modelPost else { return "" }
            return model.textArray[item]
        case .photoLib:
            guard let model = self.modelPhotoLib else { return "" }
            return model.photosForTesting[item]
        case .profilePhoto:
            guard let model = self.modelPost else { return "" }
            return model.photoPost[item]
        }
    }
    
}




