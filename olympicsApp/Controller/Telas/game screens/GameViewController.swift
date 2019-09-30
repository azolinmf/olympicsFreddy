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
import AVFoundation

protocol GameDelegate {
    func displayShop()
}

class GameViewController: UIViewController, GameOverScreenDelegate {
    
    
    var scene: CanoingGameScene!
    
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
    
    func pauseGame(pause: Bool) {
        scene.pauseGame(pause: pause)
    }
    
    
    var delegate: GameDelegate?
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        playCanoeMusic()
        
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
    
    func playCanoeMusic() {
        if Preferences.shared.isMusicOn {
            do {
                Model.instance.music = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                    Bundle.main.path(forResource: "TheCanoe", ofType: "wav")!))
                Model.instance.music.prepareToPlay()
                Model.instance.music.numberOfLoops = -1
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setCategory(AVAudioSession.Category.playback)
                }
                catch {
                }
            }
            catch {
                print("Error: could not play The Canoe music")
            }
            Model.instance.music.play()
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return false
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
    
    func gameOver(stop: Bool) {
        
        if stop {
            Model.instance.stop = true
            self.performSegue(withIdentifier: "GameOver", sender: self)
        } else if !stop {
            Model.instance.stop = false
            self.performSegue(withIdentifier: "GameOver", sender: self)
        }
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is GameOverViewController{
            guard let dest = segue.destination as? GameOverViewController else { return }
            dest.delegate = self
        }
        
    }
    
    
    
    
    
}