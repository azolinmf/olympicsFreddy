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
    var value : Float
    var inuse : Bool
    var bought : Bool
    
    
    //sobrecarga de contrutor - dessa forma, eu posso criar esse objeto com qualquer uma dessas configuracoes - Falar com a equipe sobre isso
    
    init(name : String, value : Float ,inuse : Bool, bought : Bool) {
        self.name = name
        self.value = value
        self.inuse = inuse
        self.bought = bought
    }
    
    init(name : String, value : Float) {
        self.name = name
        self.value = value
        self.inuse = false
        self.bought = false
    }
    
    init(name : String) {
        self.name = name
        self.value = 10.0
        self.inuse = false
        self.bought = false
    }
}
