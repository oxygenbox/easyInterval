//
//  RoundModeView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/17/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundModeView: UIView {
    
    //MARK- VARIABLES
    let shrinkSize: CGFloat = 0.25
    let animationSpeed: Double = 0.25
    
    lazy var intervalClock: ClockView = {
        let clock = ClockView(frame: self.bounds)
        return clock
    }()
    
    lazy var imageView: UIImageView = {
        let inset = self.frame.size.height * 0.10
        let rect = CGRect(x: inset, y: inset, width: self.bounds.width - inset*2, height: self.bounds.height - inset*2)
        let iv = UIImageView(frame: rect)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor.white
        return iv
    }()
    
    var mode: Mode = .run {
        didSet {
            configure()
        }
    }
    
    var clockColor: UIColor {
        if mode == .run {
            return UIColor.walk
        } else {
            return UIColor.run
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
    
    func configure() {
        addSubview(intervalClock)
        addSubview(imageView)
        
        switch mode {
        case .run:
            self.backgroundColor = UIColor.run
            imageView.image = UIImage(named: "run_solid")
            
        case .walk:
            self.backgroundColor = UIColor.walk
            imageView.image = UIImage(named: "walk_solid")
        default:
            break
        }
    }
    
    func beginClock(intervalSeconds: Int) {
        intervalClock.shapeLayer.strokeColor = self.clockColor.cgColor
        intervalClock.shapeLayer.lineWidth = frame.size.width - 12
        intervalClock.begin(with: intervalSeconds)
    }
    
    func pause() {
        intervalClock.pause()
    }
    
    func reset() {
        intervalClock.reset()
    }
    
    
    func grow() {
         self.intervalClock.alpha = 1
        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
            self.transform = CGAffineTransform.identity
        }
        
        animator.startAnimation()
    }
    
    func shrink() {
        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
            self.transform = CGAffineTransform(scaleX: self.shrinkSize, y: self.shrinkSize)
            self.intervalClock.alpha = 0
        }
        
        animator.addCompletion { (scale) in
        
        }
        animator.startAnimation()
    }
}

