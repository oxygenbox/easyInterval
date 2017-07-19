//
//  CountDownDot.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/19/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class CountDownDot: UIView {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
        
        addSubview(label)
    }
    
    lazy var label: UILabel = {
        let l = UILabel(frame: self.bounds)
        
        l.textAlignment = .center
        l.text = "5"
        l.textColor = UIColor.white
        let font = UIFont(name: "AvenirNext-Bold", size: 36)!
        l.font = font
        return l
    }()

    func configure(tagNum: Int) {
        tag = tagNum
        label.text = "\(tagNum)"
        backgroundColor = UIColor.dot
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        alpha = 0.0
    }
    
    func animateOn() {
        label.isHidden = false
        backgroundColor = UIColor.dot
        
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 1
        }) { (success) in
            self.animateOff()
        }
    }
    
    func animateOff() {
        UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
            self.alpha = 0
        }) { (success) in
            
        }
    }
    
    func sequenceOn() {
        label.isHidden = true
        backgroundColor = UIColor.clear
        
        self.alpha = 1
        UIView.animate(withDuration: 0.1, delay: 0.3, options: [], animations: {
            self.alpha = 0
        }) { (success) in
            self.sequenceOff()
        }
        
    }
    
    func sequenceOff() {
        label.isHidden = false
        backgroundColor = UIColor.dot
        alpha = 0
    }
}
