//
//  SpawningRocks.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 16/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class SpawningRocks: GameObject {
    
    var timer: TimeInterval = 0
    var rocksArray: [CanoingRocks] = []
    var node: SKNode
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            timer = TimeInterval.random(in: (2...6))
        }
        
        for rock in rocksArray {
            rock.update(deltaTime: deltaTime)
            
            if rock.rock.position.y <= -640 {
                rocksArray.remove(at: 0)
                rock.rock.removeFromParent()
            }
            
        }
    }

    
    func spawn() {
        let newRock = CanoingRocks()
        newRock.rock.zPosition = 2
        newRock.rock.position.x = CGFloat.random(in: (-375...375))
        newRock.rock.position.y = 645
        rocksArray.append(newRock)
        
        node.addChild(newRock.rock)
    }
    
}
