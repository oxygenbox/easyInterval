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
               // backgroundColor = UIColor.Theme.on
              //  tintColor = UIColor.Theme.off
                
                if sel {
                    backgroundColor = UIColor.white
                    tintColor = UIColor.packDark
                    
                } else {
                    backgroundColor = UIColor.clear
                    tintColor = UIColor.activeButton
                }
                
            } else {
                if sel {
                    backgroundColor = UIColor.packLight
                    tintColor = UIColor.packDark
                } else {
                    backgroundColor = UIColor.clear
                    tintColor = UIColor.packLight
                }
            }
        }
    }
    
    var sel = false
    
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = UIColor.red.cgColor
        backgroundColor = UIColor.white
        sel = true
        print("selected")
//        layer.borderColor = UIColor.activeButton.cgColor
//
    }
    
    func deselect() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
        backgroundColor = UIColor.clear
        sel = false
    }
    
    func makeInfo() {
        tintColor = UIColor.activeButton
        backgroundColor = UIColor.clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
    }

}

