//
//  CanoingPlayer.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingPlayer: SKSpriteNode, GameObject {
    
    
    func setUp(){
        let body = self.physicsBody!
        body.categoryBitMask = BodyMasks.PlayerCategory
        body.contactTestBitMask = BodyMasks.ObstacleCategory | BodyMasks.RewardCategory
        body.collisionBitMask = BodyMasks.ObstacleCategory | BodyMasks.BorderCategory
    }
    
    
    func moveRight() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: -150, dy: 0))
        
        //body.applyImpulse(CGVector(dx: 0, dy: 0), at: CGPoint(x: 50.0, y: 0))
    }
    
    func moveLeft() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: 150, dy: 0))
        //body.applyImpulse(CGVector(dx: 0, dy: 100), at: CGPoint(x: -50.0, y: 0))

    }
    
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        
        self.zRotation = self.physicsBody!.velocity.dx * -0.0015
        
    }
    
}

