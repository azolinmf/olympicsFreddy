//
//  StoreViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 17/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var viewCollectionBackGround: UIView!
    
    @IBOutlet weak var cltItems: UICollectionView!
    private var itemsPerRow : CGFloat = 4
    private let sectionInsets = UIEdgeInsets(top: 10,
                                             left: 10,
                                             bottom: 10.0,
                                             right: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        viewCollectionBackGround.layer.cornerRadius = 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllItems.shared.itemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemStore", for: indexPath) as! ItemStoreCell
        cell.lblItemName.text = AllItems.shared.itemsList[indexPath.row].name
        return cell
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
}

