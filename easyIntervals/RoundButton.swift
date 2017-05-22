//
//  RoundButton.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 3/2/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    var foreground_on = UIColor.b500
    var background_on = UIColor.b200
    var foreground_off = UIColor.b500
    var background_off = UIColor.b600
    
    
    var active: Bool = true {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth = 0
        configure()
    }
    
    func configure() {
        if active {
            backgroundColor = background_on
            tintColor = foreground_on
            layer.borderColor = foreground_on.cgColor
        } else {
            backgroundColor = background_off
            tintColor = foreground_off
            layer.borderColor = foreground_off.cgColor
        }
    }
    
    func select() {
        active = true
        configure()
        layer.borderWidth = 1
        tintColor = UIColor.b50
        layer.borderColor = UIColor.b50.cgColor
    }
    
    func deselect() {
        active = false
        configure()
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
    

}
