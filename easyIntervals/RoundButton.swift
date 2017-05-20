//
//  RoundButton.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 3/2/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    var active: Bool = true {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth = 1
        configure()
    }
    
    func configure() {
        if active {
            backgroundColor = UIColor.b200
            tintColor = UIColor.b50
            layer.borderColor = UIColor.b50.cgColor
        } else {
//            backgroundColor = UIColor.myBlue
//            tintColor = UIColor.blueC
//            layer.borderColor = UIColor.blueC.cgColor
            backgroundColor = UIColor.b200
            tintColor = UIColor.b500
            layer.borderColor = UIColor.b200.cgColor
        }
    }
    
    

}
