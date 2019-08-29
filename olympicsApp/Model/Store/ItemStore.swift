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
    var imageName : String
    var category : String
    var key : String
    
    
    //sobrecarga de contrutor - dessa forma, eu posso criar esse objeto com qualquer uma dessas configuracoes - Falar com a equipe sobre isso
    
    init(name : String, category : String, imageName : String, value : Float, inuse : Bool, bought : Bool, key : String) {
        self.name = name
        self.imageName = imageName
        self.category = category
        self.value = value
        self.inuse = inuse
        self.bought = bought
        self.key = key
    }
    
    
    static func mapToObject(dict: [String : Any]) -> ItemStore {
        //Converte o dicionario do banco de dados para um objeto do tipo ItemStore
        let name : String = dict["name"] as! String
        let value : Float = dict["value"] as! Float
        let inuse : Bool = dict["inuse"] as! Bool
        let bought : Bool = dict["bought"] as! Bool
        let category : String = dict["category"] as! String
        let imageName :  String = dict["imageName"] as! String
        let key : String = dict["key"] as! String
        
        let itemStore = ItemStore(name: name, category: category, imageName: imageName, value: value, inuse: inuse, bought: bought, key: key)
        
        return itemStore
    }
    
    
    
    
}
