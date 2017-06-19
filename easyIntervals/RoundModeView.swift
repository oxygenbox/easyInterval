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
    let shrinkSize: CGFloat = 0.5
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
        intervalClock.shapeLayer.strokeColor = UIColor.red.cgColor
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
        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
            self.transform = CGAffineTransform.identity
        }
        
        animator.startAnimation()
    }
    
    func shrink() {
        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
            self.transform = CGAffineTransform(scaleX: self.shrinkSize, y: self.shrinkSize)
        }
        
        animator.startAnimation()
    }
    
    

}

/*

 
 pac.startAnimation()
 
 
 
 func pause() {
 intervalClock.pause()
 sessionClock.pause()
 
 }
 
 func resume() {
 intervalClock.resume()
 sessionClock.resume()
 }
 
 func beginClocks(intervalSeconds: Int, sessionSeconds: Int?) {
 
 if mode == .walk {
 intervalClock.shapeLayer.strokeColor = UIColor.run.cgColor
 } else {
 intervalClock.shapeLayer.strokeColor = UIColor.walk.cgColor
 }
 
 
 intervalClock.shapeLayer.lineWidth = frame.size.height - 12
 intervalClock.begin(with: intervalSeconds)
 
 guard let t = sessionSeconds else {
 return
 }
 
 sessionClock.shapeLayer.strokeColor = UIColor.highlight.cgColor
 sessionClock.shapeLayer.lineWidth = 10
 sessionClock.isHidden = false
 sessionClock.begin(with: t)
 
 }
 
   */
