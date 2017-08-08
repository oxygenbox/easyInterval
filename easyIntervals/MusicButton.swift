//
//  MusicButton.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 8/8/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class MusicButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
         layer.borderColor = UIColor.packDark.cgColor
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.clear
        tintColor = UIColor.packDark
        titleLabel?.textColor = backgroundColor
    }

}
