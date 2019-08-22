//
//  GameScene.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import GameplayKit

extension CanoingGameScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class CanoingGameScene: SKScene, SKPhysicsContactDelegate {
    
    var backgroundNode: SKNode!
    var lastTimeUpdate: TimeInterval = 0
    var gameVel: Double = 1.0
    var spawnRock: SpawningRocks!
    var spawnFood: SpawningFood!
    var gamePoints: Int = 0
    
    var gameObjects = [GameObject] ()
    var canoingPlayer: CanoingPlayer!
    
    override func didMove(to view: SKView) {
        
        backgroundNode = childNode(withName: "backgroundNode")
        let background = CanoingBackground(node: backgroundNode)
        gameObjects.append(background)
        canoingPlayer = childNode(withName: "CanoingPlayer") as? CanoingPlayer
        canoingPlayer.setUp()
        canoingPlayer.constraints = [SKConstraint.positionY(SKRange(constantValue: -440))]
        gameObjects.append((canoingPlayer)!)
        
        spawnRock = SpawningRocks(node: self)
        spawnFood = SpawningFood(node: self)
        gameObjects.append(spawnFood)
        gameObjects.append(spawnRock)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(swipeCanoing))
        swipeDown.direction = .down
        swipeDown.delegate = self
        view.addGestureRecognizer(swipeDown)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // para limitar o player até as bordas do cel
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = BodyMasks.BorderCategory
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.ObstacleCategory) {
            //colisao com pedra
            Model.instance.totalPoints += gamePoints
            
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.BorderCategory) {
            //colisao com parede
            
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.RewardCategory) {
            //colisao com peixe
            contact.bodyB.node?.removeFromParent()
            gamePoints += 10
            
//            for gameObject in gameObjects {
//                if contact.bodyB.self == gameObject {
//
//                }
//            }
            
        }
    }
    
    @objc func swipeCanoing(sender: UIGestureRecognizer) {
        
        let location = sender.location(in: self.view)
        
        if virtualDPadRight().contains(location){
            canoingPlayer.moveRight()
            
        } else if virtualDPadLeft().contains(location){
            canoingPlayer.moveLeft()
        }
        
    }
    
    func virtualDPadLeft() -> CGRect {
        // função para criar o circulo virtual para identificar onde o usuário está clicando
        //dentro do dpadShape que é o circulo branco
        let vDPad = CGRect(x: 0, y: 0, width: self.view!.bounds.size.width / 2, height: self.view!.bounds.size.height)
        //        vDPad.origin.y = self.view!.bounds.size.height - vDPad.size.height - 10
        //        vDPad.origin.x = 10
        return vDPad
    }
    func virtualDPadRight() -> CGRect {
        // função para criar o circulo virtual para identificar onde o usuário está clicando
        //dentro do dpadShape que é o circulo branco
        let vDPad = CGRect(x: self.view!.bounds.size.width / 2, y: 0, width: self.view!.bounds.size.width / 2, height: self.view!.bounds.size.height)
        return vDPad
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastTimeUpdate == 0 {
            lastTimeUpdate = currentTime
            return
        }
        
        var deltaTime = currentTime - lastTimeUpdate
        lastTimeUpdate = currentTime
        
        //para nao zoar o jogo quando pausa
        if deltaTime >= 0.05 {
            deltaTime = 0.05
        }
        
        for gameObject in gameObjects {
            gameObject.update(deltaTime: deltaTime, velocity: gameVel)
        }
        
        if deltaTime < 0.05 {
            //random parameter that can be calibrated according to the desired game difficulty
            gameVel += deltaTime/100
        }
    }
}
