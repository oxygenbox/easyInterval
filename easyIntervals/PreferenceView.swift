//
//  PreferenceView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceView: UIView {

    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.cornerRadius = bounds.width / 2
        layer.shadowColor = UIColor.myBlue.cgColor
        layer.borderWidth = 2
        layer.borderColor = UIColor.myBlue.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.base
    }
    
}
