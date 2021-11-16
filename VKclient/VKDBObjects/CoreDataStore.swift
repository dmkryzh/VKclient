//
//  CoreDataStore.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.11.2021.
//

import Foundation
import CoreStore


    class Person: CoreStoreObject {
        @Field.Stored("name")
        var name: String = ""
        @Field.Stored("name1")
        var name1: String = ""
        @Field.Stored("name2")
        var name2: String = ""
   
    }

