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
    var music = AVAudioPlayer()
    
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


