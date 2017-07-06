//
//  PreferenceButtom.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceButton: UIButton {
    //MARK:- VARIABLES
    var isOn: Bool = false {
        didSet{
            if isOn {
                backgroundColor = UIColor.Theme.on
                tintColor = UIColor.Theme.off
            } else {
                backgroundColor = UIColor.Theme.off
                tintColor = UIColor.Theme.on
            }
        }
    }
    
    var interactive: Bool = true {
        didSet {
            if interactive {
                backgroundColor = UIColor.packDark
                tintColor = UIColor.activeButton
                layer.borderWidth = 1
                layer.borderColor = UIColor.activeButton.cgColor
            } else {
                layer.borderWidth = 0
            }
            
            isUserInteractionEnabled =  interactive
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth = 0
        tintColor = UIColor.Theme.base
    }
    
    func select() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.activeButton.cgColor
    }
    
    func deselect() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
    }
    
    func makeInfo() {
        tintColor = UIColor.activeButton
        backgroundColor = UIColor.background
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
    }

}

