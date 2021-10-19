//
//  APIClient.swift
//  VKclient
//
//  Created by Dmitrii KRY on 15.10.2021.
//

import Foundation
import Alamofire

protocol VKAPIProtocol {
    func getToken()
    func getMyAccInfo()
    func getUserAccInfo()
    func getUsers()
    func getProfilePhoto()
    func getAllPhotos()
    func getAlbums()
}

final class APIClient {
    func getToken() {}
    func getMyAccInfo() {}
    func getUserAccInfo() {}
    func getUsers() {}
    func getProfilePhoto() {}
}
