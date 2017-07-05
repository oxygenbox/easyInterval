//
//  RoundStatusView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/20/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundIntervalView: UIView {
    var mode: Mode = .run {
        didSet {
            self.label.frame = self.bounds
        }
    }
    
    lazy var clock: ClockView = {
        let clockView = ClockView(frame: self.frame)
        return clockView
    }()
    
    lazy var label: UILabel = {
        let lbl = UILabel(frame: self.bounds)
        lbl.textAlignment = .center
        let font = UIFont(name: "AvenirNext-DemiBold", size: 48)!
        lbl.font = font
        lbl.textColor = UIColor.white
        
        lbl.text = "run"
        return lbl
        
    }()
        
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
        //backgroundColor = UIColor.gray
        layer.cornerRadius = frame.size.height/2
        addSubview(clock)
        addSubview(label)
        label.frame = bounds
        
        
        if mode == .run {
            label.text = "run"
            backgroundColor = UIColor.run
        } else {
            label.text = "walk"
             backgroundColor = UIColor.walk
        }
        
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
    
    
}
