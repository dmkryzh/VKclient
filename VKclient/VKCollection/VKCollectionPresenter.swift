//
//  VKCollectionPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.01.2022.
//

import Foundation

class VKCollectionPresenter {
    
    weak var view: VKCollectionVC?
    
    var delegate: VKCollectionFlowDelegate?
    
    var modelPost: VKProfileModel?
    
    init(_ modelPost: VKProfileModel, _ view: VKCollectionVC, _ coordinator: VKCollectionFlowDelegate) {
        self.modelPost = modelPost
        self.view = view
        delegate = coordinator
    }
}

extension VKCollectionPresenter: VKProfileDataDelegate {
    func returnCellsCount(_ dataType: DataType) -> Int{
        switch dataType {
        case.profileText:
            guard let model = self.modelPost else { return 0 }
            return model.photoPost.count
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
        case .profilePhoto:
            guard let model = self.modelPost else { return "" }
            return model.photoPost[item]
        case .postSettings:
            guard let model = self.modelPost else { return "" }
            return model.postSettingsTitles[item]
        default:
            return ""
        }
    }
    
}

extension VKCollectionPresenter: VKProfilePresenterDelegate {
    func menuPressed() {
        
    }
    
    func postSettingsPressed(_ sender: Any) {
        
    }
    
    func postIsPressed() {
        
    }
    
    func photoArrowIsPressed() {
        
    }
    
    func editBttnIsPressed() {
        
    }
    


}

