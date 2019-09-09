//
//  CollectionViewB.swift
//  teste cards
//
//  Created by Saulo de Freitas Martins da Silva on 04/09/19.
//  Copyright © 2019 Saulo de Freitas Martins da Silva. All rights reserved.
//

import UIKit

class CollectionViewBackground: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.instance.bgImgs.count * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "CollectionViewBackgroundCell", for: indexPath) as! CollectionViewBackgroundCell
        
        // Sets the background img.
        cell.bgImg.image = UIImage(named: Model.instance.bgImgs[indexPath.row % Model.instance.bgImgs.count])
        
        // Sees if the game is playable
        if Model.instance.works[indexPath.row % Model.instance.bgImgs.count] {
            cell.alpha = 1.0
        } else {
            cell.alpha = 0.3
        }
        
        return cell
    }
}
