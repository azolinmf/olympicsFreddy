//
//  Esportes.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class Esportes {
    
    static var shared = Esportes()
    var sportsList : [Esporte] = []
    
    init() {
        sportsList.append(Esporte(name: "Canoagem",
                                  description: "Canoagem é um esporte onde você não se afoga"))
        sportsList.append(Esporte(name: "Ciclismo",
                                  description : "Ciclismo é massa"))
        sportsList.append(Esporte(name: "tenis",
                                  description: "Ainda nao tenho descrição"))
        sportsList.append(Esporte(name: "ping pong",
                                  description: "Ainda nao tenho descrição"))
    }

}
