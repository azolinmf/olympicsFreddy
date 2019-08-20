//
//  CanoingRocks.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 16/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingRocks: GameObject {
    
    var rock = SKSpriteNode()

    init() {
        self.rock = SKSpriteNode(imageNamed: "rock")
        let randomScale = Int.random(in: 1...2)
        self.rock.xScale = CGFloat(randomScale)
        self.rock.yScale = CGFloat(randomScale)
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        rock.position.y -= CGFloat(velocity)
        
    }
    
    
}
