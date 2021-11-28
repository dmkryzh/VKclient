//
//  VKPhotoLibPresenter.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.10.2021.
//

import Foundation

protocol VKPhotoLibFlowDelegate {
    func navigateToSomewhere()
}

class VKPhotoLibPresenter {
    
    weak var view: VKPhotoLibVC?
    var delegate: VKPhotoLibFlowDelegate?
    var dataDelegate: VKPhotoLibModelProtocol?
  
    
    init(_ view: VKPhotoLibVC, _ data: VKPhotoLibModelProtocol, _ coordinator: VKPhotoLibFlowDelegate) {
        self.view = view
        delegate = coordinator
        dataDelegate = data
    }
}

extension VKPhotoLibPresenter: VKPhotoLibVCDelegate {
    func test() {
    }
}

extension VKPhotoLibPresenter: VKPhotolibDataDelegate {
    func returnCellsCount(_ dataType: PhotoDataType) -> Int {
        
        guard let data = dataDelegate else { return 0 }
        
        if dataType == .folder {
            return data.folderImage.count
        } else {
            return data.photosForTesting.count
        }
    }
    
    func returnDataForCell(_ item: Int, _ dataType: PhotoDataType) -> String {
        
        guard let data = dataDelegate else { return "" }
        
        if dataType == .folder {
            return data.folderImage[item]
        } else {
            return data.photosForTesting[item]
        }
    }
}

