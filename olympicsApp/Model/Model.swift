//
//  Model.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 22/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//
import UIKit
import AVFoundation

class Model {
    
    static let instance = Model()
    
    var playAgain: Bool
    var stop: Bool
    var music: AVAudioPlayer!
    
    let frontImgs : [String] = [
        "Front Arremesso de peso_Prancheta 1",
        "Front Card Canoeing_Prancheta 1",
        "Front Card Bike_Prancheta 1",
        "Front Arco e Flecha_Prancheta 1"
    ]
    
    let bgImgs : [String] = [
        "BG Arremesso de peso_Prancheta 1",
        "BG Card Canoeing_Prancheta 1",
        "BG Card Bike_Prancheta 1",
        "BG Arco e Flecha_Prancheta 1"
    ]
    
    let works : [Bool] = [
        false,
        true,
        false,
        false
    ]
    
    internal init() {
        totalPoints = UserDefaults.standard.integer(forKey: "totalPoints")
        currentPoints = UserDefaults.standard.integer(forKey: "currentPoints")
        playAgain = false
        stop = false
    }
    
    var totalPoints: Int{
        didSet{
            UserDefaults.standard.set(self.totalPoints, forKey: "totalPoints")
        }
    }
    
    var currentPoints: Int{
        didSet{
            UserDefaults.standard.set(self.currentPoints, forKey: "currentPoints")
        }
    }
    

}


