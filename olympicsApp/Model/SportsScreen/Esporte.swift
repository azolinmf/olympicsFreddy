//
//  Esporte.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

class Esporte {
    
    var name : String
    var description : String
    var imagem : UIImage
    
    init(name:String, description: String, imagem: UIImage) {
        self.name = name
        self.description = description
        self.imagem = imagem
    }
}
