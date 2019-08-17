//
//  SpawningFood.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class SpawningFood: GameObject {
    
    var timer: TimeInterval = 0
    var foodArray: [CanoingFood] = []
    var node: SKNode
    var updateVel = Double(0)
    var lowerRange = Double(4)
    var upperRange = Double(8)
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            timer = TimeInterval(Double.random(in: lowerRange...upperRange))
        }
        
        for food in foodArray {
            food.update(deltaTime: deltaTime + updateVel)
            
            if food.food.position.y <= -640 {
                foodArray.remove(at: 0)
                food.food.removeFromParent()
            }
        }
        
        updateVel += deltaTime/3000
        lowerRange -= deltaTime/75
        upperRange -= deltaTime/75
    }
    
    
    func spawn() {
        let newFood = CanoingFood()
        newFood.food.zPosition = 2
        newFood.food.position.x = CGFloat.random(in: (-375...375))
        newFood.food.position.y = 645
        foodArray.append(newFood)
        
        node.addChild(newFood.food)
    }
    
}
