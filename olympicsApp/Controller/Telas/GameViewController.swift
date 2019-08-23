//
//  GameViewController.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        var scene: CanoingGameScene!
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'CanoingGameScene.sks'
            scene = SKScene(fileNamed: "CanoingGameScene") as? CanoingGameScene
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.gameViewController = self
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func gameOver() {
        self.performSegue(withIdentifier: "GameOver", sender: self)
    }
    
    
}
