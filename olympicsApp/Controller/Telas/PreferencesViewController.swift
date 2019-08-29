//
//  PreferencesViewController.swift
//  olympicsApp
//
//  Created by Saulo de Freitas Martins da Silva on 19/08/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.

import UIKit

class PreferencesViewController: UIViewController {
    
    let pref = Preferences.shared
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var languageTextField: UITextField!
    
    // TESTE: Isso substitui uma pickerview criada pelo storyboard?
    fileprivate let languagePickerView = ToolbarPickerView()
    
    @IBAction func soundChanged(_ sender: UISwitch) {
        self.pref.isSoundOn = sender.isOn
    }
    
    @IBAction func musicChanged(_ sender: UISwitch) {
        self.pref.isMusicOn = sender.isOn
    }
    
    // MARK: - Screen Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshPref()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Refreshes the status indicators
    func refreshPref() {
        self.soundSwitch.isOn = pref.isSoundOn
        self.musicSwitch.isOn = pref.isMusicOn
        self.languageTextField.text = pref.languages[pref.setLanguage]
        self.setPickerViewButtons()
    }
    
    func setPickerViewButtons(){
        self.languageTextField.inputView = self.languagePickerView
        self.languageTextField.inputAccessoryView = self.languagePickerView.toolbar
        
        self.languagePickerView.dataSource = self
        self.languagePickerView.delegate = self
        self.languagePickerView.toolbarDelegate = self
        
        self.languagePickerView.reloadAllComponents()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK : - PickerView

extension PreferencesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pref.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pref.languages[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        self.pref.setLanguage = row
    }
    
}

extension PreferencesViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        let row = self.languagePickerView.selectedRow(inComponent: 0)
        self.languagePickerView.selectRow(row, inComponent: 0, animated: false)
        self.languageTextField.text = self.pref.languages[row]
        self.pref.setLanguage = row
        quitPickerView()
    }
    
    func didTapCancel() {
        quitPickerView()
    }
    
    func quitPickerView(){
        self.languageTextField.resignFirstResponder()
    }
}
