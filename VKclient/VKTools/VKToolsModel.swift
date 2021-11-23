//
//  VKToolsModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.11.2021.
//

import Foundation
import RealmSwift

class VKToolsModel {
    
    private let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
    
    lazy var realm: Realm = {
        try? FileManager().removeItem(at: config.fileURL!)
        return try! Realm(configuration: config)
    }()
    
  
    
    func saveLink(_ link: URL) {
        let saveLink = CapturedScan()
        let stringFromURL = link.absoluteString
        saveLink.photoLink = stringFromURL
        try! realm.write {
            realm.add(saveLink)
        }
    }
    
    func loadLink() {
        let test = realm.objects(CapturedScan.self)
        print(test)
    }

}

class CapturedScan: Object {
    @objc dynamic var photoLink = ""
}

