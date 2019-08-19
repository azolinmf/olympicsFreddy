//
//  ProfileAndSportsViewController.swift
//  olympicsApp
//
//  Created by Carlos Modinez on 15/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit


class ProfileAndSportsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvSportsList: UITableView!
    var sportsList = Esportes.shared.sportsList
    
    override func viewWillAppear(_ animated: Bool) {
        tbvSportsList.delegate = self
        tbvSportsList.dataSource = self
        tbvSportsList.rowHeight = self.view.frame.height * 0.3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.lblSportDescription.text = sportsList[indexPath.row].description
        cell.lblSportName.text = sportsList[indexPath.row].name
        
        //Remove os separadores de celulas
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //inserir aqui  o caminho para o jogo
        print("Voce clicou em \(sportsList[indexPath.row].name)")
    }
    
}
