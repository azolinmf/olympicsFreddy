//
//  CanoingPlayer.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class CanoingPlayer: SKSpriteNode, GameObject {
    
    var direction = 0
    
    func setUp(){
        let body = self.physicsBody!
        body.categoryBitMask = BodyMasks.PlayerCategory
        body.contactTestBitMask = BodyMasks.ObstacleCategory | BodyMasks.RewardCategory
        body.collisionBitMask = BodyMasks.ObstacleCategory | BodyMasks.BorderCategory
    }
    
    
    func moveRight() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: -150, dy: 0))
        
        //body.applyImpulse(CGVector(dx: 0, dy: 0), at: CGPoint(x: 50.0, y: 0))
    }
    
    func moveLeft() {
        let body = self.physicsBody!
        body.applyImpulse(CGVector(dx: 150, dy: 0))
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
        for i in 1...3 {
            let PlayerTextureName  = "CanoaFreedyC\(i)"
            let PlayerTextureRight = "CanoaFreedy D\(i)"
            let PlayerTextureLeft  = "CanoaFreedy E\(i)"
            canoingFrames.append(AnimatedAtlas.textureNamed(PlayerTextureName))
            canoingRight.append(AnimatedAtlas.textureNamed(PlayerTextureRight))
            canoingLeft.append(AnimatedAtlas.textureNamed(PlayerTextureLeft))
        }
        CanoingFrames = canoingFrames
        CanoingRight  = canoingRight
        CanoingLeft   = canoingLeft
            let firstFrameTexture = AnimatedAtlas.textureNamed("CanoaFreedyC1")
            self.texture = firstFrameTexture
    }
    
    func animatePlayer(direction: Int) {
        // função para a animação do player usando as texturas
        if direction == 0 {
            self.run(SKAction.repeatForever(
                SKAction.animate(with: CanoingFrames,
                                 timePerFrame: 0.2,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlacePlayer")
        } else {
        }
        self.direction = direction
    }
    func ended(){
        removeAllActions()
    }

    
    
}

