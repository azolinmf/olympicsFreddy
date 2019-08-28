//
//  GameOverViewController.swift
//  olympicsApp
//
//  Created by MCavasin on 23/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

protocol GameOverScreenDelegate{
    func gameOver(displaysStore: Bool)
}

class GameOverViewController: UIViewController {

    @IBOutlet weak var currentPointsLabel: UILabel!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    var delegate: GameOverScreenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPointsLabel.text = String(Model.instance.currentPoints)
    }
    
    
    @IBAction func didPressStoreButton(_ sender: Any) {
        dismiss(animated: true, completion: {() in
            self.delegate?.gameOver(displaysStore: true)
        }
        )
    }
    
    
    @IBAction func didPressHomeButton(_ sender: Any) {
        dismiss(animated: true, completion: {() in
            self.delegate?.gameOver(displaysStore: false)
        }
        )
    }
    
    @IBAction func didPressPlayAgain(_ sender: Any) {
        Model.instance.playAgain = true
        dismiss(animated: false, completion: {() in
            self.delegate?.gameOver(displaysStore: false)
        }
        )
    }
    
    
}
