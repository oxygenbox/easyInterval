//
//  SwitchView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

protocol SwitchViewDelegate {
    func changePreferenceState()
}


import UIKit

class SwitchView: UIView {
    @IBOutlet weak var prefSwitch: UISwitch!
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        layer.borderWidth = 1
        layer.backgroundColor = UIColor.darkGray.cgColor
        clipsToBounds = true
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        print("SwitchChanged")
    }
}
