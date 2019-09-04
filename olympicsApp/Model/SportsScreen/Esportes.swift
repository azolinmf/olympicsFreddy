//
//  Esportes.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

class Esportes {
    
    static var shared = Esportes()
    var sportsList : [Esporte] = []
    
    init() {
        sportsList.append(Esporte(name: "Canoing",
                                  description: "Canoagem é um esporte onde você não se afoga", imagem: UIImage(named: "canoingCard")!))
        sportsList.append(Esporte(name: "Archery",
                                  description: "Arqueiros piu piu piu fodasi", imagem: UIImage(named: "archeryCard")!))
        sportsList.append(Esporte(name: "Canoing",
                                  description: "Darlan Romani recordista de arremesso 22m bixo", imagem: UIImage(named: "arremessoCard")!))
    }

}
