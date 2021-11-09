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
    case postSettings
}

class VKProfilePresenter {
    
    weak var view: VKProfileVC?
    
    var delegate: VKProfileFlowDelegate?
    
    var modelPost: VKProfileModel?
    
    var modelPhotoLib: VKPhotoLibModel?
    
    init(_ modelPost: VKProfileModel, modelPhotoLib: VKPhotoLibModel, _ view: VKProfileVC, _ coordinator: VKProfileFlowDelegate) {
        self.modelPost = modelPost
        self.modelPhotoLib = modelPhotoLib
        self.view = view
        delegate = coordinator
    }
}

extension VKProfilePresenter: VKProfilePresenterDelegate {
    @objc func postSettingsPressed(_ sender: Any) {
        delegate?.postSettingsIsChosen(sender)
    }
    
    @objc func menuPressed() {
        delegate?.settingsFlowIsChosen()
    }
}

extension VKProfilePresenter: VKProfileDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int{
        switch dataType {
        case.profileText:
            guard let model = self.modelPost else { return 0 }
            return model.photoPost.count
        case.photoLib:
            guard let model = self.modelPhotoLib else { return 0 }
            return model.photosForTesting.count
        case.postSettings:
            guard let model = self.modelPost else { return 0 }
            return model.postSettingsTitles.count
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
        case .postSettings:
            guard let model = self.modelPost else { return "" }
            return model.postSettingsTitles[item]
        }
    }
    
}




