//
//  CanoingPlayer.swift
//  olympicsApp
//
//  Created by Matheus Cavasin on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingPlayer: SKSpriteNode, GameObject {
    
    var direction = 0
    
    func setUp(){
        
//        var body = self.physicsBody!
//        self.physicsBody! = SKPhysicsBody(circleOfRadius: CGFloat(30))
//        self.texture = AnimatedAtlas.textureNamed("CanoaFreedy1")
        print("sizes;")
        print(self.texture?.size())
        print(self.size)
        
        let CanoingTexture = SKTexture(imageNamed: "Canoa.png")
        
        self.scale(to: CGSize(width: (self.texture?.size().width)! * 0.2, height: (self.texture?.size().height)! * 0.2))
        self.physicsBody = SKPhysicsBody(texture: CanoingTexture, alphaThreshold: 0.8, size: CGSize(width: self.size.width + 20, height: self.size.height + 20))
        //self.physicsBody! = SKPhysicsBody(texture: AnimatedAtlas.textureNamed("CanoaFreedyC1"), size: CGSize(width: self.size.width * CGFloat(1.1), height: self.size.height * CGFloat(1.1)))
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.isDynamic = true
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.categoryBitMask = BodyMasks.PlayerCategory
        self.physicsBody!.contactTestBitMask = BodyMasks.ObstacleCategory | BodyMasks.RewardCategory | BodyMasks.BorderCategory
        self.physicsBody!.collisionBitMask = BodyMasks.ObstacleCategory | BodyMasks.BorderCategory
        self.physicsBody!.restitution = 0.1
        
        // hook.ink
    }
    
    
    func moveRight() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: -190, dy: 0))
        animatePlayer(direction: 2)
        //body.applyImpulse(CGVector(dx: 0, dy: 0), at: CGPoint(x: 50.0, y: 0))
    }
    
    func moveLeft() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: 190, dy: 0))
        animatePlayer(direction: 1)
        //body.applyImpulse(CGVector(dx: 0, dy: 100), at: CGPoint(x: -50.0, y: 0))

    }
    
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        
        self.zRotation = self.physicsBody!.velocity.dx * -0.0015

    }
    
    
    //MARK: Animaçao com as texturas
    
    var CanoingFrames: [SKTexture] = []   // array de texturas player reto
    var CanoingRight : [SKTexture] = []   // array de texturas player direita
    var CanoingLeft  : [SKTexture] = []   // array de texturas player esquerda
    let AnimatedAtlas = SKTextureAtlas(named: "CanoingPlayer") // salvar as imagens do arquivo atlas
    
    func buildCanoingTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var canoingFrames: [SKTexture] = []
        var canoingRight : [SKTexture] = []
        var canoingLeft  : [SKTexture] = []
        for i in 1...10 {
            let PlayerTexture  = "CanoaFreedy\(i)"
            canoingFrames.append(AnimatedAtlas.textureNamed(PlayerTexture))
            if i < 6 {
                canoingLeft.append(AnimatedAtlas.textureNamed(PlayerTexture))
            } else if i > 5 {
                canoingRight.append(AnimatedAtlas.textureNamed(PlayerTexture))
            }
        }
        CanoingFrames = canoingFrames
        CanoingRight  = canoingRight
        CanoingLeft   = canoingLeft
        self.texture = AnimatedAtlas.textureNamed("CanoaFreedy1")
        setUp()
    }
    
    func animatePlayer(direction: Int) {
        let padling = SKAction.repeatForever(
            SKAction.animate(with: CanoingFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: true))
        let padlingRight = SKAction.animate(with: CanoingRight,
                                            timePerFrame: 0.2,
                                            resize: false,
                                            restore: true)
        let padlingLeft = SKAction.animate(with: CanoingLeft,
                                            timePerFrame: 0.2,
                                            resize: false,
                                            restore: true)
        // função para a animação do player usando as texturas
        if direction == 0 {
            self.run(padling,
                     withKey:"walkingInPlacePlayer")
        } else if direction == 1{
            self.run(SKAction.sequence([padlingRight,padling]))
        } else if direction == 2 {
            self.run(SKAction.sequence([padlingLeft,padling]))
        }
        self.direction = direction
    }
    func ended(){
        removeAllActions()
    }

    
    
}

