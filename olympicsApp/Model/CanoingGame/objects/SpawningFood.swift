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
    var distance = 1000.0 //1000.0
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            //calcula o tempo para criar novo peixe, para que a distancia se mantenha a msm
            //multiplica a velocidade em pixels/frame por 60 para virar pixels/segundo
            timer = distance/(velocity*60)
        }
        
        for food in foodArray {
            food.update(deltaTime: deltaTime, velocity: velocity)
            
            if food.food.position.y <= -640 {
                foodArray.remove(at: 0)
                food.food.removeFromParent()
            }
        }

    }
    
    
    func spawn() {
        let newFood = CanoingFood()
        newFood.setUp()
        foodArray.append(newFood)
        
        node.addChild(newFood.food)
    }
    
}
