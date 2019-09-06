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

protocol GameDelegate {
    func displayShop()
}

class GameViewController: UIViewController, GameOverScreenDelegate {
    
    weak var gameOverView: GameOverViewController!
    
    func gameOver(displaysStore: Bool) {
        navigationController?.popViewController(animated: true)
        
        if displaysStore {
            //vai pra loja
            self.delegate?.displayShop()
        } else {
            //nao vai pra loja
            if Model.instance.playAgain {
                //joga de novo
                if let vc = storyboard?.instantiateViewController(withIdentifier: "canoingGame") as? GameViewController {
                    vc.delegate = delegate
                    self.navigationController?.show(vc, sender: self)
//                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
            //vai pra home
        }
        
    }
    
    
    var delegate: GameDelegate?
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        var scene: CanoingGameScene!
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'CanoingGameScene.sks'
            scene = SKScene(fileNamed: "CanoingGameScene") as? CanoingGameScene
            // Set the scale mode to scale to fit the window
//            scene.scaleMode = .aspectFit
            scene.scaleMode = .aspectFill
            scene.gameViewController = self
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsPhysics = false
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
    
    func pauseGame() {
//        let alert = UIAlertController(title: "⏯", message: "",preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "Home",
//                                      style: UIAlertAction.Style.default,
//                                      handler: {(_: UIAlertAction!) in
//                                        self.navigationController?.popViewController(animated: true)
//        }))
//
//        alert.addAction(UIAlertAction(title: "Resume",
//                                      style: UIAlertAction.Style.default,
//                                      handler: {(_: UIAlertAction!) in
//                                        print("inferno")
//
//        }))
//
//        self.present(alert, animated: true, completion: nil)
        
        gameOverView.changeIcons()
        
        self.performSegue(withIdentifier: "GameOver", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is GameOverViewController{
            guard let dest = segue.destination as? GameOverViewController else { return }
            dest.delegate = self
        }
        
    }
    
    
    
    
    
}
