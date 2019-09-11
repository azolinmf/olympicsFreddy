//
//  ProfileAndSportsViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ProfileAndSportsViewController : UIViewController, GameDelegate {
    
    @IBOutlet weak var configurationButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var lblTotalPoints: UILabel!
    
    
    var profileGameScene: StoreGameScene!
    
    var sportsList = Esportes.shared.sportsList
    
    // For the cards selection. Define wich card is shown in both CollectionViews.
    var syncIndex : Int!
    
    // The card selection is made with two CollectionViews, one behind (background) and one in front of Freddy.
    @IBOutlet weak var collectionViewFront: CollectionViewFront!
    @IBOutlet weak var collectionViewBackground: CollectionViewBackground!
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
                
            case .right:
                syncIndex = syncIndex - 1
                
                // A posição da cell buscada na collection view nunca poderá ser menor do que 0
                if syncIndex < 0 {
                    syncIndex = 0
                }
                refreshCards(animated: true)
            case .left:
                syncIndex = (syncIndex + 1) % (Model.instance.frontImgs.count * 1000)
                refreshCards(animated: true)
            default:
                break
            }
        }
    }
    
    // Move the front and the bg card CollectionView synchronous.
    func refreshCards(animated: Bool){
        collectionViewFront.scrollToItem(at: IndexPath(row: syncIndex, section: 0), at:  UICollectionView.ScrollPosition.centeredHorizontally, animated: animated)
        collectionViewBackground.scrollToItem(at: IndexPath(row: syncIndex, section: 0), at:  UICollectionView.ScrollPosition.centeredHorizontally, animated: animated)
    }
    
    override func viewDidLoad() {
        lblTotalPoints.text = String(Model.instance.totalPoints)
        collectionViewFront.delegate = collectionViewFront
        collectionViewFront.dataSource = collectionViewFront
        collectionViewFront.profileVC = self
        collectionViewBackground.delegate = collectionViewBackground
        collectionViewBackground.dataSource = collectionViewBackground
        
        if let view = gameView {
            profileGameScene = SKScene(fileNamed: "StoreGameScene") as? StoreGameScene
            profileGameScene.scaleMode = .aspectFill
            profileGameScene.psvc = self
            view.presentScene(profileGameScene)
            
            DAOItemsStore.initialLoad(){
                self.profileGameScene.setOutfit()
            }
        }
        
        // Centralize the first card
        syncIndex = Model.instance.frontImgs.count * 500
        refreshCards(animated: false)
        
        // Set a RIGHT swipe recognizer. The default direction is right.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        // And the LEFT swipe as well.
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        // Add the Swipe Recognizer to the storyboard.
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        
    }
    
    func playMenuMusic() {
        if Preferences.shared.isMusicOn {
            do {
                Model.instance.music = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                    Bundle.main.path(forResource: "OlympicsMenu", ofType: "wav")!))
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
                print("Error: could not play menu music")
            }
            Model.instance.music.play()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateInterface()
        self.profileGameScene.setOutfit()
        playMenuMusic()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func displayShop() {
        self.performSegue(withIdentifier: "shopSegue", sender: self)
    }
    
    func displayGame(gameIndex: Int) {
        if gameIndex == 0 {
            self.performSegue(withIdentifier: "presentGame", sender: self)
        } else {
            print("Usuario tentando acessar jogo inexistente")
        }
    }
    func updateInterface(){
        
        buttonShadow(v: configurationButton, blur: 7, y: 2, opacity: 0.2)
        buttonShadow(v: storeButton, blur: 7, y: 2, opacity: 0.2)
        
    }
    
    func buttonShadow (v : UIButton!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
    }
    
    func viewshadow (v : UIView!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameViewController{
            dest.delegate = self
        }
    }
}
