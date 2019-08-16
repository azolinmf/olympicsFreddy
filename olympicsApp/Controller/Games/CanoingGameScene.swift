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
    
    var background :  SKSpriteNode!
    var timerControler = 0
    
    override func didMove(to view: SKView) {
        
        background = childNode(withName: "background") as? SKSpriteNode
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){_ in
            if self.timerControler == 0 {
                self.background.texture = SKTextureAtlas(named: "Background").textureNamed("back1")
                self.timerControler = 1
            } else {
                self.background.texture = SKTextureAtlas(named: "Background").textureNamed("back2")
                self.timerControler = 0
            }
        }
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
        
        
    }
}
