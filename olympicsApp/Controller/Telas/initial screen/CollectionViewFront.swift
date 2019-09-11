//
//  CollectionViewA.swift
//  teste cards
//
//  Created by Saulo de Freitas Martins da Silva on 05/09/19.
//  Copyright © 2019 Saulo de Freitas Martins da Silva. All rights reserved.
//

import UIKit

class CollectionViewFront: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var profileVC : ProfileAndSportsViewController!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.instance.frontImgs.count * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "CollectionViewFrontCell", for: indexPath) as! CollectionViewFrontCell
        
        // Hides background.
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        // Set the front img.
        cell.frontImg.image = UIImage(named: Model.instance.frontImgs[indexPath.row % Model.instance.frontImgs.count])
        
        // Sees if the game is playable
        if Model.instance.works[indexPath.row % Model.instance.bgImgs.count] {
            cell.frontImg.alpha = 1.0
            cell.availableSoonLabel.isHidden = true
        } else {
            cell.frontImg.alpha = 0.3
            cell.availableSoonLabel.isHidden = false
        }
        
        return cell
    }
    
    // Seleciona o jogo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row % Model.instance.bgImgs.count == 1 {
            profileVC.performSegue(withIdentifier: "presentGame", sender: self)
        }
    }
}
