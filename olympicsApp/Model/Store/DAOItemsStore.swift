//
//  DAOItemsStore.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation
import Firebase

//DAO = Data Access Object

class DAOItemsStore {
    
    static func initialLoad (completion : @escaping ()  -> ()) {
        AllItems.shared.inUseItems.removeAll()
        
        let db = Firestore.firestore()
        db.collection("AllItems").getDocuments { (querySnapshot, err) in
            var item : ItemStore
            
            if let err = err {
                print("//////////////////////: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    item = ItemStore.mapToObject(dict: document.data())
                    if item.inuse == true {
                        AllItems.shared.inUseItems.append(item)
                    }
                }
                completion()
            }
            AllItems.shared.insertItemInCategory()
        }
    }
    
    
    static func load(completion : @escaping ()  -> ()) {
        let db = Firestore.firestore()
        
        db.collection("AllItems").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("//////////////////////: \(err)")
            } else {
                AllItems.shared.allItemsStore.removeAll()
                AllItems.shared.clearItemsFromCategories()
                var item : ItemStore
                
                //For que pega todos os elementos da colecao Store do FireBase
                for document in querySnapshot!.documents {
                    
                    //Cria um ItemStore a partir do dicionário o coloca no vetor de todos os itens
                    item = ItemStore.mapToObject(dict: document.data())
                    AllItems.shared.allItemsStore.append(item)
                }
                completion()
            }
            AllItems.shared.insertItemInCategory()
        }
    }
}
