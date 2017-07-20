//
//  infoView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/6/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class InstructionView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var twoFingerView: UIView!
    @IBOutlet weak var twoFingerImage: UIImageView!
    @IBOutlet weak var fingerA: UIView!
    @IBOutlet weak var fingerB: UIView!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var handBaseConstraint: NSLayoutConstraint!
    
    var fingerATimer: Timer!
    var fingerBTimer: Timer!
    
    var cycleTimer: Timer?
    
    var handsOn: CGFloat = 8
    var handsOff: CGFloat = -200
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        config()
        
    }
    
    //MARK:- Methods
    func config() {
        
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth  = 2
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.walk.cgColor, UIColor.run.cgColor]
       // gradientLayer.colors = [UIColor.packDark.cgColor, UIColor.dot.cgColor]
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        backgroundColor = UIColor.walk
       // handBaseConstraint.constant = handsOff
        twoFingerImage.tintColor = UIColor.white
        descLabel.textColor = UIColor.white
       // isHidden = true
    }
    
    func initTwoFingerPulse() {
        fingerATimer = Timer.scheduledTimer(withTimeInterval: 0.45, repeats: true, block: { (timer) in
            self.addPulse(target: self.fingerA, duration: 0.5)
            self.addPulse(target: self.fingerB, duration: 0.5)
        })
        
        fingerBTimer = Timer.scheduledTimer(withTimeInterval: 0.45, repeats: true, block: { (timer) in
            self.addPulse(target: self.fingerA, duration: 0.75)
            self.addPulse(target: self.fingerB, duration: 0.75)
        })
    }
    
    func addPulse(target: UIView, duration: Double) {
        let radius = target.frame.width * 2.5
        let pulse = Pulsing(numberOfPulses: 1, radius: radius/2, position: target.center)
        pulse.animationDuration = duration
        pulse.backgroundColor = UIColor.clear.cgColor
        pulse.borderWidth = 3
        pulse.borderColor = UIColor.white.cgColor
        twoFingerView.layer.insertSublayer(pulse, below: target.layer)
    }

    func stopPulse() {
        guard let timerA = fingerATimer, let timerB = fingerBTimer else {
            return
        }
        
        timerA.invalidate()
        timerB.invalidate()
    }
    
    
    func toggle() {
        if isHidden {
            alpha = 0
            isHidden = false
            center.y -= 50
            UIView.animate(withDuration: 0.35, animations: {
                self.alpha = 1
                self.center.y += 50
            }, completion: { (success) in
                self.animateTwoFingerOn()
                self.startCycle()
            })
        } else {
            data.firstVisit = false
            data.save()
            stopPulse()
            UIView.animate(withDuration: 0.35, animations: {
                self.alpha = 0
            }, completion: { (success) in
                self.isHidden = true
                self.handBaseConstraint.constant = self.handsOff
                
            })
        }
    }
    
    func animateTwoFingerOn() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.handBaseConstraint.constant = self.handsOn
            self.layoutIfNeeded()
        }) { (success) in
            self.initTwoFingerPulse()
            self.stopCycle()
        }
        
    }
    
    func show() {
        alpha = 0
        isHidden = false
        center.y -= 50
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
            self.center.y += 50
        }, completion: { (success) in
            self.animateTwoFingerOn()
            self.startCycle()
        })
    }
    
    func startCycle() {
        if cycleTimer == nil {
            
        }
    }
    
    func stopCycle() {
        if let cycle = cycleTimer {
            cycle.invalidate()
            self.cycleTimer = nil
        }
    }
}

