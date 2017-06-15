//
//  PreferenceViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {

    
    //MARK- OUTLETS
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var intervalOrderControl: UISegmentedControl!
    @IBOutlet weak var switchView: SwitchView!
    
    //MARK- VARIABLES
    var isRunWalk = true
    var runSetting = 0
    var walkSetting = 0
    
    var runComponent: Int {
        if isRunWalk {
            return 0
        } else {
            return 1
        }
    }
    
    var wallComponent: Int {
        if isRunWalk {
            return 1
        } else {
            return 0
        }
    }
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ACTIONS
    @IBAction func preferenceButtonTapped(_ sender: PreferenceButton) {
       // self.updateSwitchVview(destination: sender.center.x)
        self.postionSwitchView(destination: sender.center.x)
    }
    
    @IBAction func intervalOrderChanged(_ sender: UISegmentedControl) {
        isRunWalk = sender.selectedSegmentIndex == 0
        picker.reloadAllComponents()
        picker.selectRow(runSetting, inComponent: runComponent, animated: false)
        picker.selectRow(walkSetting, inComponent: wallComponent, animated: false)
    }
    
    //MARK:- METHODS
    func postionSwitchView(destination: CGFloat) {
        let pa = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            self.switchView.center.x = destination
        }
        
        pa.startAnimation()
    }


}

//MARK:- EXTENSIONS
extension PreferenceViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        runSetting = picker.selectedRow(inComponent: runComponent)
        walkSetting = picker.selectedRow(inComponent: wallComponent)
    }
}

extension PreferenceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        let dim = pickerView.bounds.width/2 - 10
        let pView = UIView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
        pView.layer.cornerRadius = dim/2
        pView.backgroundColor = UIColor.blue
        let label = UILabel(frame: pView.frame)
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 40)!
        label.text = "\(row):00"
        label.textAlignment = .center
        pView.addSubview(label)

        
        if component == runComponent {
            pView.backgroundColor = UIColor.green
        } else {
             pView.backgroundColor = UIColor.red
        }
        
        return pView
    }
}


/*
 
 

 */
