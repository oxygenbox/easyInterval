//
//  Tutorial.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/24/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class Tutorial: UIView {
    var timer: Timer!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.size.height/2
        
        backgroundColor = UIColor.orange
        triggerPulse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func triggerPulse() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (success) in
            self.addPulse()
        }
    }
    
    
    
    func addPulse() {
            let radius = frame.width //* 0.8
            let pulse = Pulsing(numberOfPulses: 1, radius: radius/2, position: self.center)
            pulse.animationDuration = 0.5
            pulse.backgroundColor = UIColor.jake.cgColor
            layer.insertSublayer(pulse, at: 1)
    }

}
