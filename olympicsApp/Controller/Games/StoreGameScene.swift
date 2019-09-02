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
    var selectedItem : ItemStore!
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
    }
    
    func changeShirt() {
        
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        
        let referencia = Storage.storage().reference(withPath: "t-shirts/\(self.selectedItem.imageName)")
        
        image.sd_setImage(with: referencia)
        self.shirt.texture = SKTexture(image: image.image as! UIImage)
        
    }
    
    func changePants() {
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        
        let referencia = Storage.storage().reference(withPath: "pants/\(self.selectedItem.imageName)")
        
        image.sd_setImage(with: referencia)
        self.pants.texture = SKTexture(image: image.image as! UIImage)
    }
    
    func  changeMustache() {
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        
        let referencia = Storage.storage().reference(withPath: "mustaches/\(self.selectedItem.imageName)")
        
        image.sd_setImage(with: referencia)
        self.pants.texture = SKTexture(image: image.image as! UIImage)
    }
    
    func changeHats() {
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        
        let referencia = Storage.storage().reference(withPath: "hats/\(self.selectedItem.imageName)")
        
        image.sd_setImage(with: referencia)
        self.pants.texture = SKTexture(image: image.image as! UIImage)
    }
    
    func changeGlasses() {
        var image : UIImageView
        image = UIImageView(image: UIImage(named: "rock"))
        
        let referencia = Storage.storage().reference(withPath: "glasses/\(self.selectedItem.imageName)")
        
        image.sd_setImage(with: referencia)
        self.pants.texture = SKTexture(image: image.image as! UIImage)
    }
}
