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
        layer.borderWidth = 2
        configure()
    }
    
    func configure() {
        if active {
            backgroundColor = UIColor.white
            tintColor = UIColor.myBlue
            layer.borderColor = UIColor.myBlue.cgColor
        } else {
            backgroundColor = UIColor.myBlue
            tintColor = UIColor.blueC
            layer.borderColor = UIColor.blueC.cgColor
        }
    }
    
    

}
