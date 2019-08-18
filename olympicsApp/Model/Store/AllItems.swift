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
    var itemsList : [ItemStore] = []
    
    init() {
        itemsList.append(ItemStore(name: "Oculos",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "pijama",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "chupeta",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "sapato",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "bolsa",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "boné",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "Oculos",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "pijama",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "chupeta",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "sapato",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "bolsa",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "boné",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "Oculos",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "pijama",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "chupeta",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "sapato",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "bolsa",
                                   inuse: false,
                                   bought: false))
        itemsList.append(ItemStore(name: "boné",
                                   inuse: false,
                                   bought: false))
    }
}
