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
        let usedItem = Outfit.getOutfit()
        for index in 0..<usedItem.count {
            changeItem(with: usedItem[index].category, imageName: usedItem[index].imageName)
        }
    }
//    func changeItem(with category: String) {
//        var image : UIImageView
//        image = UIImageView(image: UIImage(named: "rock"))
//        let refe = Storage.storage().reference(withPath: "\(category)/\(self.selectedItem.imageName)")
//        image.sd_setImage(with: refe)
//        self.pants.texture = SKTexture(image: image.image as! UIImage)
//    }
    
    func changeItem(with category: String, imageName: String) {
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        let refe = Storage.storage().reference(withPath: "\(category)/\(imageName)")
        image.sd_setImage(with: refe)
        if category == "t-shirts" {
            self.shirt.texture = SKTexture(image: image.image as! UIImage)
        } else if category == "pants" {
            self.pants.texture = SKTexture(image: image.image as! UIImage)
        } else if category == "mustaches"{
            self.mustaches.texture = SKTexture(image: image.image as! UIImage)
        } else if category == "glasses" {
            self.glasses.texture = SKTexture(image: image.image as! UIImage)
        } else {
            self.hats.texture = SKTexture(image: image.image as! UIImage)
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
