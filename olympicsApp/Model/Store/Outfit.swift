//
//  AllItems.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

class Outfit {
    
    static func buyItem(categoryPosition : Int,  itemPosition : Int) -> Bool {
    
        let item = AllItems.shared.categories[categoryPosition].items[itemPosition]
        
        if checkMoney(item: item) == true {
            item.bought = true
            item.inuse = true
            
            AllItems.shared.inUseItems.append(item)
            Model.instance.totalPoints -= item.value
            
            let DBRef = Firestore.firestore()
            
            
            DBRef.collection("AllItems").document(item.key).setData(["bought" : true], merge: true)
            DBRef.collection("AllItems").document(item.key).setData(["inuse" : true], merge: true)
    
            
            //FREDDy nao pode usar dois items  de uma mesma categoria\
            for i in AllItems.shared.categories[categoryPosition].items {
                
                if i.key != item.key {
                    i.inuse = false
                    
                    DBRef.collection("AllItems")
                        .whereField("key", isEqualTo: i.key)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print(err.localizedDescription)
                            } else if querySnapshot!.documents.count != 1 {
                                // Perhaps this is an error for you?
                            } else {
                                let document = querySnapshot!.documents.first
                                document!.reference.updateData([
                                    "inuse": false
                                    ])
                            }
                    }
                }
            }
            
            
            let inUseItemsSize = AllItems.shared.inUseItems.count-1
            for i in stride(from: inUseItemsSize, to: -1, by: -1) {
                if item.category == AllItems.shared.inUseItems[i].category && item.key != AllItems.shared.inUseItems[i].key {
                    AllItems.shared.inUseItems.remove(at: i)
                }
            }
            
            return true
        }
        else {
            return false
        }
    }
    
    static func useItem (categoryPosition : Int , itemPosition : Int) {
        if  itemPosition >= 0 {
            let item = AllItems.shared.categories[categoryPosition].items[itemPosition]
            let DBRef = Firestore.firestore()
            
            //        FIRDatabase.database().reference().child("feed-items")
            if item.bought == true {
                item.inuse = true
                AllItems.shared.inUseItems.append(item)
                
            
                DBRef.collection("AllItems").document(item.key).setData(["inuse" : true], merge: true)
                
                //FREDDy nao pode usar dois items  de uma mesma categoria\
                for i in AllItems.shared.categories[categoryPosition].items {
        
                    if i.key != item.key {
                        i.inuse = false
                        
                        DBRef.collection("AllItems")
                            .whereField("key", isEqualTo: i.key)
                            .getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print(err.localizedDescription)
                                } else if querySnapshot!.documents.count != 1 {
                                    // Perhaps this is an error for you?
                                } else {
                                    let document = querySnapshot!.documents.first
                                    document!.reference.updateData([
                                        "inuse": false
                                        ])
                                }
                        }
                    }
                }
                
                
                let inUseItemsSize = AllItems.shared.inUseItems.count-1
                
                for i in stride(from: inUseItemsSize, to: -1, by: -1) {
                    if item.category == AllItems.shared.inUseItems[i].category && item.key != AllItems.shared.inUseItems[i].key {
                        AllItems.shared.inUseItems.remove(at: i)
                    }
                }
            }
        }
    }
    
    static func undressItem(categoryPosition : Int) {
        
        let DBRef = Firestore.firestore()
        
        for item in AllItems.shared.categories[categoryPosition].items {
            if item.inuse == true {
                item.inuse = false
                
                
                let inUseItemsSize = AllItems.shared.inUseItems.count
                for i in 0..<inUseItemsSize {
                    if item.key == AllItems.shared.inUseItems[i].key {
                        AllItems.shared.inUseItems.remove(at: i)
                    }
                }
                
                
                DBRef.collection("AllItems")
                    .whereField("key", isEqualTo: item.key)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print(err.localizedDescription)
                        } else if querySnapshot!.documents.count != 1 {

                        } else {
                            let document = querySnapshot!.documents.first
                            document!.reference.updateData([
                                "inuse": false
                            ])
                        }
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
    static func getOutfit() {
        var inUseItems = AllItems.shared.inUseItems
       
        for index in 0..<AllItems.shared.categories.count {
            for item in AllItems.shared.categories[index].items {
                    
                if item.inuse == true {
                    inUseItems.append(item)
                }
            }
        }
    }
    
}
