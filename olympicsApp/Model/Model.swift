//
//  Model.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 22/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//
import UIKit

class Model {
    
    static let instance = Model()
    
    internal init() {
        totalPoints = UserDefaults.standard.integer(forKey: "totalPoints")
    }
    
    var totalPoints: Int{
        didSet{
            UserDefaults.standard.set(self.totalPoints, forKey: "totalPoints")
        }
    }
    

}


