//
//  ItemStore.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class ItemStore {
    var name : String
    var inuse : Bool
    var bought : Bool
    
    init(name : String, inuse : Bool, bought : Bool) {
        self.name = name
        self.inuse = inuse
        self.bought = bought
    }
}
