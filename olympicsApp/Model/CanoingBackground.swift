//
//  CanoingBackground.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 16/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingBackground: GameObject {
    
    let node: SKNode
    
    init(node: SKNode) {
        self.node = node
        setAnimation()
    }
    
    func update(deltaTime: TimeInterval) {
        let velY = CGFloat(1)
        node.position.y -= velY
        
        if node.position.y < 70 {
            node.position.y += 70
        }
    }
    
    func setAnimation() {
        if let background = node.childNode(withName: "AnimationNode") {
            
            let range = CGFloat(210.0)
            let moveBackground = SKAction.moveBy(x: range, y: 0, duration: 5)
            moveBackground.timingMode = .easeInEaseOut
            let moveBackgroundBack = SKAction.moveBy(x: -range, y: 0, duration: 5)
            moveBackgroundBack.timingMode = .easeInEaseOut
            let sequence = SKAction.sequence([moveBackground, moveBackgroundBack])
            background.run(SKAction.repeatForever(sequence))
            
        }
        else {
            fatalError("node should have a child named background")
        }
        
    }
    
}
