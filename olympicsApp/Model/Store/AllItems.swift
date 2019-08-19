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

        //TEm outro jeito de add multiplos elementos em um array de objetos?
        
        itemsList.append(ItemStore(name: "Oculos"))
        itemsList.append(ItemStore(name: "boné"))
        itemsList.append(ItemStore(name: "gorro"))
        itemsList.append(ItemStore(name: "Salto alto"))
        itemsList.append(ItemStore(name: "Salto baixo"))
        itemsList.append(ItemStore(name: "Carrinho"))
        itemsList.append(ItemStore(name: "lancha"))
        itemsList.append(ItemStore(name: "Cor da orelha"))
    }
}
