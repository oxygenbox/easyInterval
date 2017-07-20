//
//  ButtonView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/22/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.Theme.buttonBar
        backgroundColor = UIColor.clear
       // addGradient()
    }
    
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.packLight.cgColor, UIColor.dot.cgColor]
        
       // gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
       // gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
