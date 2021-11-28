//
//  VKFeedPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.11.2021.
//

import Foundation

protocol VKFeedFlowDelegate {
    func settingsFlowIsChosen()
    func postSettingsIsChosen(_ sender: Any)
    func testScanIsChosen()
    func friendProfileIsChosen()
}

class VKFeedPresenter {
    
    weak var view: VKFeedVC?
    
    var delegate: VKFeedFlowDelegate?
    
    var modelPost: VKProfileModel?
    
    var modelStories: VKPhotoLibModel?
    
    init(_ modelPost: VKProfileModel, _ modelPhotoLib: VKPhotoLibModel, _ view: VKFeedVC, _ coordinator: VKFeedFlowDelegate) {
        self.modelPost = modelPost
        self.modelStories = modelPhotoLib
        self.view = view
        delegate = coordinator
    }
}

extension VKFeedPresenter: VKFeedPresenterDelegate {
    func friendProfileFlowIsChosen() {
        delegate?.friendProfileIsChosen()
    }
    
    func testSomeSettingIsChosen() {
        delegate?.testScanIsChosen()
    }
    
    @objc func postSettingsPressed(_ sender: Any) {
        delegate?.postSettingsIsChosen(sender)
    }
    
    @objc func menuPressed() {
        delegate?.settingsFlowIsChosen()
    }
}

extension VKFeedPresenter: VKFeedDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int{
        switch dataType {
        case.profileText:
            guard let model = self.modelPost else { return 0 }
            return model.photoPost.count
        case.photoLib:
            guard let model = self.modelStories else { return 0 }
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
            guard let model = self.modelStories else { return "" }
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
