//
//  File.swift
//  olympicsApp
//
//  Created by Saulo de Freitas Martins da Silva on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation

class Preferences {
    
    static let shared = Preferences()
    
    var isSoundOn : Bool = true
    var isMusicOn : Bool = true
    
    // Languages associated with the Strings as they are shown in the Preferences Screen.
    let languages : [String] =
        [
            "English",
            "Português",
            "Língua do P"
    ]
    // Index of the Language array
    var setLanguage : Int = 1
    
}
