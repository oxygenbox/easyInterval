//
//  RoundButton.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 3/2/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    var isOn: Bool = false {
        didSet{
            if isOn {
                backgroundColor = UIColor.Theme.on
            } else {
                backgroundColor = UIColor.Theme.base
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth = 0
        tintColor = UIColor.Theme.bar
    }
    
    
    
    func select() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.Theme.borderOn.cgColor
    }
    
    func deselect() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.Theme.borderOff.cgColor
    }
    
    func makeInfo() {
        tintColor = UIColor.Theme.on
    }
    

}
