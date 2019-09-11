//
//  StoreGameScene.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 26/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import GameplayKit
import Firebase
import FirebaseUI
import UIKit

class StoreGameScene :  SKScene {
    var vc : StoreViewController!
    var psvc : ProfileAndSportsViewController!
    var  freddy : SKSpriteNode!
    
    var shirt : SKSpriteNode!
    var pants : SKSpriteNode!
    var hats : SKSpriteNode!
    var glasses : SKSpriteNode!
    var mustaches : SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        freddy = childNode(withName: "freddy") as? SKSpriteNode
        
        shirt = freddy.childNode(withName: "shirt") as? SKSpriteNode
        pants = freddy.childNode(withName: "pants") as? SKSpriteNode
        hats = freddy.childNode(withName: "hats") as? SKSpriteNode
        glasses = freddy.childNode(withName: "glasses") as? SKSpriteNode
        mustaches = freddy.childNode(withName: "mustaches") as? SKSpriteNode
        
        setOutfit()
    }

    func setOutfit() {
        Outfit.getOutfit()
        let inUsedItem = AllItems.shared.inUseItems
        
        for index in 0..<inUsedItem.count {
            if inUsedItem[index].inuse == true {
                changeItem(with: inUsedItem[index].category, imageName: inUsedItem[index].imageName)
            }
            else {
                changeItem(with: inUsedItem[index].category)
            }
        }
    }
    
        func changeItem(with category: String, imageName: String) {
            
            let pathReference = Storage.storage().reference(withPath: "\(category)")
            let islandRed = pathReference.child("\(imageName)")
           
            islandRed.getData (maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    print("\n\n\n\n\(error.localizedDescription)")
                } else {
                    let image = UIImage(data: data!)
                    
                    if category == "t-shirts" {
                        self.shirt.texture = SKTexture(image: image!)
                    } else if category == "pants" {
                        self.pants.texture = SKTexture(image: image!)
                    } else if category == "mustaches"{
                        self.mustaches.texture = SKTexture(image: image!)
                    } else if category == "glasses" {
                        self.glasses.texture = SKTexture(image: image!)
                    } else {
                        self.hats.texture = SKTexture(image: image!)
                    }
                }
            }
            
            
            
        }
    
    func changeItem (with category : String) {
        if category == "t-shirts" {
            self.shirt.texture = nil
        } else if category == "hats" {
            self.hats.texture = nil
        } else if category == "glasses"{
            self.glasses.texture = nil
        } else if category == "pants" {
            self.pants.texture = nil
        } else {
            self.mustaches.texture = nil
        }
    }
    func changeItem(with category : Int) {
        print(category)
        if category == 0 {
            self.shirt.texture = nil
        } else if category == 1 {
            self.hats.texture = nil
        } else if category == 2{
            self.glasses.texture = nil
        } else if category == 3 {
            self.pants.texture = nil
        } else {
            self.mustaches.texture = nil
        }
    }
}
