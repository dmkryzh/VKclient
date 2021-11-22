//
//  CoreDataStore.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.11.2021.
//

import Foundation
import CoreStore


class ScannedImage: CoreStoreObject {
    @Field.Stored("imageLink")
    var imageLink: String = ""
}

class Post: CoreStoreObject {
    @Field.Stored("postIsCreatedBy")
    var postIsCreatedBy: String = ""
}

