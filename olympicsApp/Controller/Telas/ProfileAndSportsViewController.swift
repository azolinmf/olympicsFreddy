//
//  ProfileAndSportsViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit


class ProfileAndSportsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,  GameDelegate {
    
    func displayShop() {
        self.performSegue(withIdentifier: "shopSegue", sender: self)
    }
    
    @IBOutlet weak var configurationButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var tbvSportsList: UITableView!
    var sportsList = Esportes.shared.sportsList
    
    override func viewWillAppear(_ animated: Bool) {
        tbvSportsList.delegate = self
        tbvSportsList.dataSource = self
        tbvSportsList.rowHeight = self.view.frame.height * 0.3
        
        updateInterface()
        
    }
    
    func updateInterface(){
        
        buttonShadow(v: configurationButton, blur: 7, y: 2, opacity: 0.2)
        buttonShadow(v: storeButton, blur: 7, y: 2, opacity: 0.2)
        
    }
    
    func buttonShadow (v : UIButton!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
    }
    
    func viewshadow (v : UIView!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.lblSportDescription.text = sportsList[indexPath.row].description
        cell.lblSportName.text = sportsList[indexPath.row].name
        
        viewshadow(v: cell.viewBackgroundCell, blur: 7, y: 2, opacity: 0.6)
        //Remove os separadores de celulas
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //inserir aqui  o caminho para o jogo
//        if indexPath.row == 0 {
//            if let vc = storyboard?.instantiateViewController(withIdentifier: "canoingGame") as? GameViewController {
//                self.navigationController?.show(vc, sender: self)
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //inserir aqui  o caminho para o jogo
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "presentGame", sender: self)
            //            if let vc = storyboard?.instantiateViewController(withIdentifier: "canoingGame") as? GameViewController {
            //                self.navigationController?.show(vc, sender: self)
            //            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameViewController{
            dest.delegate = self
        }
    }
}
