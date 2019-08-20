//
//  CanoingFood.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingFood: GameObject {
    
    var food = SKSpriteNode()
    
    init() {
        self.food = SKSpriteNode(imageNamed: "fish")
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        food.position.y -= CGFloat(velocity)
        
    }
    
    
}

