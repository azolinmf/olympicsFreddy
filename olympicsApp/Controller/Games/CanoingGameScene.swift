//
//  GameScene.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import GameplayKit

class CanoingGameScene: SKScene {
    
    var backgroundNode: SKNode!
    
    var lastTimeUpdate: TimeInterval = 0
    
    var gameObjects = [GameObject] ()
    
    override func didMove(to view: SKView) {
        
        backgroundNode = childNode(withName: "backgroundNode")
        let background = CanoingBackground(node: backgroundNode)
        gameObjects.append(background)

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
        
        let deltaTime = currentTime - lastTimeUpdate
        lastTimeUpdate = currentTime
        
        for gameObject in gameObjects {
            gameObject.update(deltaTime: deltaTime)
        }
        
        
    }
}
