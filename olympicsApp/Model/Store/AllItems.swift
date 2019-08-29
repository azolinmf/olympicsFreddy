//
//  AllItems.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class AllItems {
    
    static var shared = AllItems()
    var categories : [StoreCategories] = []
    var allItemsStore : [ItemStore] = []
    
    init() {
        categories.append(StoreCategories(name: "t-shirts"))
        categories.append(StoreCategories(name: "shoes"))
        categories.append(StoreCategories(name: "glasses"))
        categories.append(StoreCategories(name: "pants"))
        categories.append(StoreCategories(name: "hats"))
    }
    
    func insertItemInCategory() {
        for i in 0..<self.allItemsStore.count {
            for j in 0..<self.categories.count {
                if self.categories[j].name == self.allItemsStore[i].category {
                    categories[j].items.append(allItemsStore[i])
                }
            }
        }
        AllItems.shared.allItemsStore.removeAll()
    }
    
    func clearItemsFromCategories() {
        for i in 0..<self.categories.count {
            self.categories[i].items.removeAll()
        }
    }
}
