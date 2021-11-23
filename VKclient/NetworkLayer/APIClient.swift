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
    
    private var tokenDelegate: LoginPresenterDataDelegate
    
    private(set) var headersForFeed: HTTPHeaders = []
    
    private(set) var parametersForFeed: [String: Any] = [
        "access_token": "",
        "v": 5.131,
        "filters": "post",
        "count": 10
    ]
    
    func updateToken() -> Bool {
        guard let token = tokenDelegate.token else { return false }
        parametersForFeed["access_token"] = token
        return true
    }
    
    func getRequest(_ parameters: [String: Any], _ headers: HTTPHeaders? = nil, _ link: String) {
        guard updateToken() else { return }
        AF.request(link, method: .get, parameters: parameters, headers: headers).responseData {
            response in
            switch response.result {
            case .success(let feedObject):
                DataParser.parseToFeedModel(feedObject) { object in
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(_ tokenDelegate: LoginPresenterDataDelegate) {
        self.tokenDelegate = tokenDelegate
    }
}


