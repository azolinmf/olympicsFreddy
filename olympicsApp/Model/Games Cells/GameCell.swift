//
//  GameCell.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    @IBOutlet weak var viewBackgroundCell: UIView!
    @IBOutlet weak var lblSportName: UILabel!
    @IBOutlet weak var lblSportDescription: UILabel!
    @IBOutlet weak var imgSport: UIImageView!
    
    override func awakeFromNib() {
        viewBackgroundCell.layer.cornerRadius = 20
    }

}
