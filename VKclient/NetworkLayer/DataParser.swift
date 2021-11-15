//
//  DataParser.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.11.2021.
//

import Foundation
import CoreStore

class DataParser {
    
    static func parseToFeedModel(_ data: Data, _ completion: ((FeedModel) -> Void)? = nil) {
        do {
            let jsonDecoder = JSONDecoder()
            let response = try jsonDecoder.decode(FeedModel.self, from: data)
            print(response)
            if let completion = completion {
                completion(response)
            }
        } catch {
            print(error)
            
        }
    }
}

