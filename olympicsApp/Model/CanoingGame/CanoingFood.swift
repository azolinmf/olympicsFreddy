//
//  CanoingFood.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingFood: SKSpriteNode, GameObject {
    
    var food = SKSpriteNode(imageNamed: "fish")
    
    func setUp() {
        let foodTexture = SKTexture(imageNamed: "fish")
        
//        food.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        food.physicsBody = SKPhysicsBody(texture: foodTexture, alphaThreshold: 0.8, size: CGSize(width: food.size.width, height: food.size.height))
        food.zPosition = 0 //2
        food.position.x = CGFloat.random(in: (0...740))
        food.position.y = 1794
        food.physicsBody?.categoryBitMask = BodyMasks.RewardCategory
        food.physicsBody?.contactTestBitMask = BodyMasks.PlayerCategory
        //food.physicsBody?.collisionBitMask = BodyMasks.PlayerCategory
        food.physicsBody?.isDynamic = false
        
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        food.position.y -= CGFloat(velocity)
        
    }
    
    func remove() {
        food.removeFromParent()
    }
    
    
}

