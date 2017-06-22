//
//  RoundStatusView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/20/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundStatusView: UIView {
    
    var clock: ClockView?
        
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(frame: CGRect) {
        self.frame = frame
        backgroundColor = UIColor.gray
        layer.cornerRadius = frame.size.height/2
        
        if clock == nil {
            clock = ClockView(frame: frame)
            clock?.backgroundColor = UIColor.yellow
            addSubview(clock!)
        }
        
    }

}
