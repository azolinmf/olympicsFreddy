//
//  TestePedra.swift
//  olympicsApp
//
//  Created by MCavasin on 21/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//


import SpriteKit

class CanoingRocks: SKSpriteNode, GameObject {
    
    var rock = SKSpriteNode(imageNamed: "rock")
    
    func SetUp() {
        self.rock = SKSpriteNode(imageNamed: "rock")
        let randomScale = Int.random(in: 1...2)
        self.rock.xScale = CGFloat(randomScale)
        self.rock.yScale = CGFloat(randomScale)
        
        rock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        rock.zPosition = 0 //2
        rock.position.x = CGFloat.random(in: (-375...375))
        rock.position.y = 680
        rock.physicsBody?.categoryBitMask = BodyMasks.ObstacleCategory
        rock.physicsBody?.contactTestBitMask = BodyMasks.PlayerCategory
        rock.physicsBody?.collisionBitMask = BodyMasks.PlayerCategory
        rock.physicsBody?.isDynamic = false
    }
    
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        rock.position.y -= CGFloat(velocity)
        
    }
    
    
}
