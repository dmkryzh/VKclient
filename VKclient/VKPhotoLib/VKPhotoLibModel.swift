//
//  VKPhotoLibModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.10.2021.
//

import Foundation

enum PhotoDataType {
    case folder
    case photo
}

protocol VKPhotoLibModelProtocol {
    var photosForTesting: [String] { get }
    var threeDots: String { get }
    var folderImage: [String] { get }
}

struct VKPhotoLibModel: VKPhotoLibModelProtocol {

    let photosForTesting = ["1ava", "arch", "australian", "beach", "buildings", "cat", "child", "circle", "city", "face", "forest"]
    
    let threeDots = "ellipsis"
    
    let folderImage = ["folder"]
}

