//
//  StoreCategories.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class StoreCategories {
    var name : String
    var items : [ItemStore]
    
    init(name : String, items : [ItemStore]) {
        self.name = name
        self.items = items
    }
    
    init(name : String) {
        self.name = name
        self.items = []
    }
    
}
