//
//  SceneBackground.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class SceneBackground: SKSpriteNode {
    
    //MARK: Animacao
    var backgrounds: [SKTexture] = []
    let backgroundAtlas = SKTextureAtlas(named: "Background")
    
    func buildBackgroundTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var backFrames: [SKTexture] = []
        let numImages = backgroundAtlas.textureNames.count
        for i in 1...(numImages) {
            let BackgroundTextureName = "back\(i)"
            backFrames.append(backgroundAtlas.textureNamed(BackgroundTextureName))
        }
        backgrounds = backFrames
        
    }
    func animateBackground() {
        
        self.run(SKAction.repeatForever(
            SKAction.animate(with: backgrounds,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: true)),
                 withKey:"changingBackground")
        
    }
    
    func ended(){
        removeAllActions()
    }

    
}
