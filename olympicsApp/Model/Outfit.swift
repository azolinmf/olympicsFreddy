//
//  AllItems.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class Outfit {
    
    var shirt : ItemStore
    var pants : ItemStore
//    var hats : ItemStore
//    var glasses : ItemStore
    
    
    init(shirt : ItemStore, pants : ItemStore) {
        self.shirt = shirt
        self.pants = pants
    }
    
    func buyItem(categoryPosition : Int,  itemPosition : Int) -> Bool {
        
        let item = AllItems.shared.categories[categoryPosition].items[itemPosition]
        
        if checkMoney(item: item) == true {
            item.bought = true
            item.inuse = true

            return true
        }
            
        else {
            return false
        }
    }
    func useItem
    
    func checkMoney(item : ItemStore) -> Bool {
        if Model.instance.totalPoints >= item.value {
            return true
        }
        else {
            return false
        }
    }
}
