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
        
    }
    
    func update(deltaTime: TimeInterval) {
        let velY = CGFloat(1)
        rock.position.y -= velY
        
    }
    
    
}
