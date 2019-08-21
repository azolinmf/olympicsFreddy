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
//    var rocksArray: [CanoingRocks] = []
    var rocksArray: [CanoingRocks] = []
    var node: SKNode
    var distance = 750.0
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            //calcula o tempo para criar nova pedra, para que a distancia se mantenha a msm
            //multiplica a velocidade em pixels/frame por 60 para virar pixels/segundo
            timer = distance/(velocity*60)
        }
        
        for rock in rocksArray {
            rock.update(deltaTime: deltaTime, velocity: velocity)
            
            if rock.rock.position.y <= -640 {
                rocksArray.remove(at: 0)
                rock.rock.removeFromParent()
            }
        }
        
    }
    
    func spawn() {
        let newRock = CanoingRocks()
        newRock.SetUp()
        var body = newRock.rock.physicsBody
        rocksArray.append(newRock)
        newRock.rock.zPosition = 0 //2
        newRock.rock.position.x = CGFloat.random(in: (-375...375))
        newRock.rock.position.y = 645
        node.addChild((newRock.rock as! SKSpriteNode))
        print(body?.contactTestBitMask)
    }

    /*
    func spawn() {
        let newRock = CanoingRocks()
        var body = newRock.rock.physicsBody
        body = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        newRock.rock.zPosition = 0 //2
        newRock.rock.position.x = CGFloat.random(in: (-375...375))
        newRock.rock.position.y = 645
        body?.categoryBitMask    = BodyMasks.ObstacleCategory
        body?.contactTestBitMask = BodyMasks.PlayerCategory
        body?.collisionBitMask   = BodyMasks.PlayerCategory
        body?.mass = 2
        body?.affectedByGravity = false
        body?.isDynamic = true
        rocksArray.append(newRock)
        node.addChild((newRock.rock as! SKSpriteNode))
        print(body?.node)

    } */
    
}
