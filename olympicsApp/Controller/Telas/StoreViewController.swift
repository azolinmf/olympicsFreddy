//
//  StoreViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import SpriteKit
import GameplayKit

class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var viewCollectionBackGround: UIView!
    @IBOutlet weak var btnCategoryOne: UIButton!
    @IBOutlet weak var btnCategoryTwo: UIButton!
    @IBOutlet weak var btnCategoryThree: UIButton!
    @IBOutlet weak var btnCategoryFour: UIButton!
    @IBOutlet weak var btnCategoryFive: UIButton!
    @IBOutlet weak var btnBuyItem: UIButton!
    @IBOutlet weak var btnUseButton: UIButton!
    
    
    @IBOutlet weak var lblTotalPoints: UILabel!
    
    @IBOutlet weak var gameView: SKView!
    
    var buttonPressed = 0
    var itemChoiced = 0
    
    var storeGameScene: StoreGameScene!
    
    @IBOutlet weak var cltItems: UICollectionView!
    private var itemsPerRow : CGFloat = 4
    private let sectionInsets = UIEdgeInsets(top: 10,
                                             left: 10,
                                             bottom: 10.0,
                                             right: 10)
    
    
    
    override func viewDidLoad() {
        if let view = gameView {
            storeGameScene = SKScene(fileNamed: "StoreGameScene") as? StoreGameScene
            storeGameScene.scaleMode = .aspectFill
            storeGameScene.vc = self
            view.presentScene(storeGameScene)
            Model.instance.totalPoints = 100
        }
        
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewCollectionBackGround.layer.cornerRadius = 50
        // A colecao so atualiza apos carregar as informacoes do banco de dado
        
        DAOItemsStore.load {
            self.updateScreen()
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func updateScreen() {
        self.cltItems.reloadData()
        lblTotalPoints.text = String(Model.instance.totalPoints)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllItems.shared.categories[buttonPressed].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemStore", for: indexPath) as! ItemStoreCell
        
        let item = AllItems.shared.categories[buttonPressed].items[indexPath.row]
        cell.setCell(for: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = AllItems.shared.categories[buttonPressed].items[indexPath.row]
        //        let ref  : DatabaseReference!
        //        ref = Database.database().reference()
        //        ref.child("AllItems/\(itemSelected.key)/inuse").setValue("true")
        //        print("Trocando para true")
        
        itemChoiced = indexPath.row
        storeGameScene.selectedItem = itemSelected
        if buttonPressed == 0 {
            storeGameScene.changeShirt()
        } else if buttonPressed == 1 {
            storeGameScene.changeHats()
        } else if buttonPressed == 2 {
            storeGameScene.changeGlasses()
        } else if buttonPressed == 3 {
            storeGameScene.changePants()
        } else {
            storeGameScene.changeMustache()
        }
        
        setButtons(item: itemSelected)
        updateScreen()
    }
    
    
    func setButtons(item : ItemStore){
        if item.bought == true {
            showUseButton()
        }
        else {
            showBuyButton()
        }
    }
    
    @IBAction func btnCategoryOnePressed(_ sender: Any) {
        buttonPressed = 0
        updateScreen()
    }
    @IBAction func btnCategoryTwoPressed(_ sender: Any) {
        buttonPressed = 1
        updateScreen()
    }
    
    @IBAction func btnCategoryThreePressed(_ sender: Any) {
        buttonPressed = 2
        updateScreen()
    }
    
    @IBAction func btnCategoryFourPressed(_ sender: Any) {
        buttonPressed = 3
        updateScreen()
    }
    
    @IBAction func btnCategoryFivePressed(_ sender: Any) {
        buttonPressed = 4
        updateScreen()
    }
    
    @IBAction func btnBuyItemPressed(_ sender: Any) {
        
        if Outfit.buyItem(categoryPosition: buttonPressed, itemPosition: itemChoiced) == true {
            print("Comprado")
            showUseButton()
        }
        else {
            print("Voce  nao tem  dinheiro o suficiente")
        }
        
        updateScreen()
    }
    
    @IBAction func btnUseItemPressed(_ sender: Any) {
        Outfit.useItem(categoryPosition: buttonPressed, itemPosition: itemChoiced)
        updateScreen()
    }
    
    func showBuyButton (){
        btnBuyItem.isHidden = false
        btnBuyItem.isEnabled = true
        
        btnUseButton.isHidden = true
        btnUseButton.isEnabled = false
    }
    func showUseButton (){
        btnBuyItem.isHidden = true
        btnBuyItem.isEnabled = false
        
        btnUseButton.isHidden = false
        btnUseButton.isEnabled = true
    }
}

extension StoreViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace : CGFloat = (sectionInsets.left * itemsPerRow) + 15
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func buyItem (categoryPosition : Int, itemPosition : Int) {
        
    }
    
}

