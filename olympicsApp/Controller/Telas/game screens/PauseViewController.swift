//
//  PauseViewController.swift
//  olympicsApp
//
//  Created by Maria Fernanda Azolin on 05/09/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit

protocol PauseScreenDelegate {
    func gameOver(displaysStore: Bool)
}

class PauseViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var delegate: PauseScreenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didPressHomeButton(_ sender: Any) {
        dismiss(animated: true, completion: {() in
            self.delegate?.gameOver(displaysStore: false)
        }
        )
    }
    
    @IBAction func didPressPlayButton(_ sender: Any) {
    }
    

}
