//
//  PreferenceView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceView: UIView {

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        layer.cornerRadius = bounds.height / 2
        //        layer.shadowColor = UIColor(red: CGFloat(157.0) / 255.0, green: CGFloat(157.0) / 255.0, blue: CGFloat(157.0) / 255.0, alpha: 0.9).CGColor
        backgroundColor = UIColor.white
        
        layer.shadowColor = UIColor.myBlue.cgColor
        layer.borderWidth = 2
        layer.borderColor = UIColor.myBlue.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        
        backgroundColor = UIColor.base
        
            }
    
    
    
    

}
