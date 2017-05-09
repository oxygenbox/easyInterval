//
//  TimerView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/16/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit
import QuartzCore

class TimerView: UIView {
    
    @IBOutlet weak var intervalTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    var bgView: UIView!

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
       
      
    }
    
       


}
