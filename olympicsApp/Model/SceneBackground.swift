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
    
    
    
    func ended(){
        removeAllActions()
    }

    
}
