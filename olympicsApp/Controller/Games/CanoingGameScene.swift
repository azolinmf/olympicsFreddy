//
//  GameScene.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox
import AVFoundation


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
    var grama: SKNode!
    var lastTimeUpdate: TimeInterval = 0
    var gameVel: Double = 6.0
    var spawnRock: SpawningRocks!
    var spawnFood: SpawningFood!
    var gamePoints: Int = 0
    var boardProportion = CGFloat(0)
    var hideLabel = false
    var instructionLabel: SKLabelNode!
    var currentPoints: SKLabelNode!
    var pauseButton: SKNode!
    
    var gameObjects = [GameObject] ()
    var canoingPlayer: CanoingPlayer!
    weak var gameViewController: GameViewController!
    
    var rowingSound = AVAudioPlayer()
    var fishSound = AVAudioPlayer()
    var firstTimePlayingSound = true
    
    
    
    override func didMove(to view: SKView) {
        
        Model.instance.playAgain = false
        instructionLabel = (childNode(withName: "instructionLabel") as? SKLabelNode)!
        currentPoints = (childNode(withName: "currentPoints") as? SKLabelNode)!
        pauseButton = childNode(withName: "pause")
        pauseButton.name = "pauseButton"
        
        
        let flashLabelIn = SKAction.fadeIn(withDuration: 2.0)
        let flashLabelOut = SKAction.fadeOut(withDuration: 0.2)
        let sequence = SKAction.sequence([flashLabelIn, flashLabelOut])
        
        instructionLabel.run(SKAction.repeatForever(sequence))

        backgroundNode = childNode(withName: "backgroundNode")
//        grama = childNode(withName: "grama")
//        grama.physicsBody!.collisionBitMask = BodyMasks.PlayerCategory
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
        
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // para limitar o player até as bordas do cel
        self.physicsWorld.contactDelegate = self
//        self.physicsBody?.categoryBitMask = BodyMasks.BorderCategory
//        self.physicsBody!.restitution = 0.6
        
        
        
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
            Model.instance.currentPoints = gamePoints
            vibrate()
            
            gameViewController.gameOver(stop: false)
            isPaused = true
            
//            self.view?.addSubview(viewGameOver)
            
            
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.BorderCategory) {
            //colisao com parede
            canoingPlayer.zRotation = 0.0
        } else if(firstBody.categoryBitMask == BodyMasks.PlayerCategory) &&
            (secondBody.categoryBitMask == BodyMasks.RewardCategory) {
            //colisao com peixe
            contact.bodyB.node?.removeFromParent()
            var alreadyIncrementedPoints = false
            if !alreadyIncrementedPoints {
                gamePoints += 10
                alreadyIncrementedPoints = true
            }
            
            playFishSound()
            
            currentPoints.text = String(gamePoints)
        }
    }
    
    @objc func swipeCanoing(sender: UIGestureRecognizer) {
        let location = sender.location(in: self.view)
        if location.x > canoingPlayer.position.x * boardProportion {
            canoingPlayer.moveRight()
            playRowingSound()

        } else if location.x < canoingPlayer.position.x * boardProportion {
            canoingPlayer.moveLeft()
            playRowingSound()
        }
        
    }
    
    func vibrate(){

        if Preferences.shared.isVibrationOn {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    
    }
    
    
    func playRowingSound() {
        
        if Preferences.shared.isSoundOn {
            
            if !firstTimePlayingSound {
                
                if !rowingSound.isPlaying {
                    do {
                        rowingSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                            Bundle.main.path(forResource: "RowingSound", ofType: "wav")!))
                        rowingSound.prepareToPlay()
                        let audioSession = AVAudioSession.sharedInstance()
                        do {
                            try audioSession.setCategory(AVAudioSession.Category.playback)
                        }
                        catch {
                        }
                    }
                    catch {
                        print(error)
                    }
                    rowingSound.play()
                }
                
            }
            else {
                //primeira vez que entrou na funcao, toca o som anyway
                do {
                    rowingSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                        Bundle.main.path(forResource: "RowingSound", ofType: "wav")!))
                    rowingSound.prepareToPlay()
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setCategory(AVAudioSession.Category.playback)
                    }
                    catch {
                    }
                }
                catch {
                    print(error)
                }
                rowingSound.play()
                
                firstTimePlayingSound = false
            }
            
        }
        
    }
    
    func playFishSound() {
        
        if Preferences.shared.isSoundOn {
            do {
                fishSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                    Bundle.main.path(forResource: "FishReward", ofType: "wav")!))
                fishSound.prepareToPlay()
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setCategory(AVAudioSession.Category.playback)
                }
                catch {
                }
            }
            catch {
                print(error)
            }
            fishSound.play()
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
            gameVel += deltaTime/8  //100
        }
        
        
        
    }
    
    func pauseGame (pause: Bool){
        self.isPaused = pause
        pauseButton.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    
        if !hideLabel {
            _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { timer in
                self.instructionLabel.isHidden = true
            })
            hideLabel = true
        }
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "pauseButton" {
                if !isPaused {
                    pauseButton.isHidden = true
                    pauseGame(pause: true)
//                    playButton.isHidden = false
                    gameViewController.gameOver(stop: true)
                }
                
            }
          
        }
        
    }
    
}
