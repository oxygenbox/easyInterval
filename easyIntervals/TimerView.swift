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
      
        setUp()
      
    }
    
    func setUp() {
        backgroundColor = UIColor.clear
        
        
        let bgColor = UIColor.orange
        let radius: CGFloat = 8.0
        
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        bgView.backgroundColor = bgColor
        bgView.layer.cornerRadius = radius
        
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        bgView.layer.shadowRadius = 5.0
        bgView.layer.shadowOpacity = 0.7
        bgView.alpha = 0
        
        insertSubview(bgView, at: 0)
        
        
        let cover = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        cover.backgroundColor = bgColor
        cover.clipsToBounds = true
        cover.layer.cornerRadius = radius
        
        insertSubview(cover, at: 0)
        insertSubview(bgView, at: 0)
    
       
    }
    
    
    func rise() {
        UIView.animate(withDuration: 0.5) {
            self.bgView.alpha = 1
        }
    }
    
    func sink() {
        UIView.animate(withDuration: 0.5) {
            self.bgView.alpha = 0
        }
    }
    


}
