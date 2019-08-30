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
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
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
    var boardProportion = CGFloat(0)
    
    var gameObjects = [GameObject] ()
    var canoingPlayer: CanoingPlayer!
    weak var gameViewController: GameViewController!
    
    override func didMove(to view: SKView) {
        
        Model.instance.playAgain = false

        backgroundNode = childNode(withName: "backgroundNode")
        let background = CanoingBackground(node: backgroundNode)
        gameObjects.append(background)
        canoingPlayer = childNode(withName: "CanoingPlayer") as? CanoingPlayer
        canoingPlayer.buildCanoingTexture()
//        canoingPlayer.setUp()
        canoingPlayer.animatePlayer(direction: 0)
//        canoingPlayer.texture = SKTexture(imageNamed: "CanoaFreedyC1")
        canoingPlayer.constraints = [SKConstraint.positionY(SKRange(constantValue: 230))]
        gameObjects.append((canoingPlayer)!)
        boardProportion = self.view!.frame.width / frame.width

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
            let viewGameOver = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width/2, height: self.frame.size.height/2))
            viewGameOver.center = self.view!.center
            viewGameOver.backgroundColor = .white
            Model.instance.totalPoints += gamePoints
            Model.instance.currentPoints = gamePoints
            gameViewController.gameOver()
            isPaused = true
//            self.view?.addSubview(viewGameOver)
        
            
            
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.BorderCategory) {
            //colisao com parede
            
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.RewardCategory) {
            //colisao com peixe
            contact.bodyB.node?.removeFromParent()
            gamePoints += 10
            
//            for gameObject in gameObjects {
//                if contact.bodyB == gameObject {
//                    gameObjects.remove(at: )
//                }

            
        }
    }
    
    @objc func swipeCanoing(sender: UIGestureRecognizer) {
        let location = sender.location(in: self.view)
        if location.x > canoingPlayer.position.x * boardProportion {
            canoingPlayer.moveRight()
            canoingPlayer.animatePlayer(direction: 2)

        } else if location.x < canoingPlayer.position.x * boardProportion {
            canoingPlayer.moveLeft()
            canoingPlayer.animatePlayer(direction: 1)

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
            gameVel += deltaTime   //100
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
}
