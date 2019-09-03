//
//  ProfileAndSportsViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import SpriteKit

class ProfileAndSportsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  GameDelegate {
    
    @IBOutlet weak var configurationButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var cltSports: UICollectionView!
    @IBOutlet weak var gameView: SKView!
    
    var profileGameScene: StoreGameScene!
    
    
    var sportsList = Esportes.shared.sportsList
    
    override func viewDidLoad() {
        cltSports.delegate = self
        cltSports.dataSource = self
        
        
        
        if let view = gameView {
            profileGameScene = SKScene(fileNamed: "StoreGameScene") as? StoreGameScene
            profileGameScene.scaleMode = .aspectFill
            profileGameScene.psvc = self
            
            view.presentScene(profileGameScene)
            Model.instance.totalPoints = 100
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileGameScene.setOutfit()
        updateInterface()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.lblSportName.text = sportsList[indexPath.row].name
        //Remove os separadores de celulas
        return cell
    }
    
    
    func displayShop() {
        self.performSegue(withIdentifier: "shopSegue", sender: self)
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

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "presentGame", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameViewController{
            dest.delegate = self
        }
    }
}
