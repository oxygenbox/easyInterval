//
//  PlainButton.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/26/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PlainButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        //layer.borderWidth = 1
        //layer.borderColor = UIColor.Theme.borderOff.cgColor
       
        
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.activeButton
         tintColor = UIColor.background
        titleLabel?.textColor = backgroundColor
    }
    

}
