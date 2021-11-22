//
//  VKToolsModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.11.2021.
//

import Foundation
import CoreStore

class VKToolsModel {

    let dataStore = DataStack()
    
    func startStorage() {
        do {
        try dataStore.addStorageAndWait()
        }
        catch {
            
        }
    }
    
    func getObjects() {

        let objects = try? dataStore.fetchAll(From<ScannedImage>())
        print(objects as Any )

    }
    
    init?() {
        startStorage()
    }
    
    
}


