//
//  ItemStoreCell.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class ItemStoreCell: UICollectionViewCell {
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgImageItem: UIImageView!

    
    func setCell (for itemStore: ItemStore) {
        
        let referencia = Storage.storage().reference(withPath: "\(itemStore.category)/\(itemStore.imageName)")
        
        //cell.imgImageItem.sd_setImage(with: referencia, placeholderImage: "placeholder")
        self.imgImageItem.sd_setImage(with: referencia)
        self.lblItemName.text = String(itemStore.value)
    }
    func setCellAsEmpty () {
        self.imgImageItem.image = UIImage(named: "nullIcon")
        self.lblItemName.text = "None"
    }
}
