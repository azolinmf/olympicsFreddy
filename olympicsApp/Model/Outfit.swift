//
//  AllItems.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class Outfit {
    
    static func buyItem(categoryPosition : Int,  itemPosition : Int) -> Bool {
        
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
    
    
    static func useItem (categoryPosition : Int , itemPosition : Int) {
        let item = AllItems.shared.categories[categoryPosition].items[itemPosition]
        
        if item.bought == true {
            item.inuse = true
            
            //FREDDy nao pode usar dois items  de uma mesma categoria\
            for i in AllItems.shared.categories[categoryPosition].items {
                
                if i.key != item.key {
                    i.inuse = false
                }
            }
        }
    }
    
    static func checkMoney(item : ItemStore) -> Bool {
        if Model.instance.totalPoints >= item.value {
            return true
        }
        else {
            return false
        }
    }
    
    
    //Nao  está otimizado
    static func getOutfit() -> [ItemStore] {
        var inUseItems : [ItemStore]
        inUseItems = []
        
        for index in 0...AllItems.shared.categories.count{
            for index2 in 0...AllItems.shared.categories[index].items.count {
                
                if AllItems.shared.categories[index].items[index2].inuse == true {
                    inUseItems.append(AllItems.shared.categories[index].items[index2])
                }
            }
        }
        return inUseItems
    }
    
}
