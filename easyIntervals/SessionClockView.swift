//
//  SessionClockView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/27/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class SessionClockView: UIView {lazy var clock: ClockView = {
    
    let clockColor = UIColor.packDark
    
    let dim = self.frame.width
        return ClockView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
    }()

    
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        clock.alpha = 0.75
        addSubview(clock)
        
        let imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(named: "session_panel")
        imageView.alpha = 0.3
        addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func beginClock(intervalSeconds: Int) {
        clock.shapeLayer.strokeColor = UIColor.packDark.cgColor
        clock.shapeLayer.lineWidth = clock.frame.size.width * 0.80
        clock.begin(with: intervalSeconds)
    }
    
    func pause() {
        clock.pause()
    }
    
    func reset() {
        clock.reset()
    }
    
    func resume() {
        if clock.hasStarted {
            clock.resume()
        }
    }

    
    
    

}
