//
//  infoView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/6/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var twoFingerView: UIView!
    @IBOutlet weak var twoFingerImage: UIImageView!
    @IBOutlet weak var fingerA: UIView!
    @IBOutlet weak var fingerB: UIView!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var handBaseConstraint: NSLayoutConstraint!
    
    var fingerATimer: Timer!
    var fingerBTimer: Timer!
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var handsOn: CGFloat = 8
    var handsOff: CGFloat = -200
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        config()
        
    }
    
    func config() {
        backgroundColor = UIColor.Theme.borderOn
        twoFingerImage.tintColor = UIColor.Theme.on
        descLabel.textColor = UIColor.Theme.on
        isHidden = true
        
        
        handBaseConstraint.constant = handsOff
        
      
        
        
        
    }
    
    func initTwoFingerPulse() {
        fingerATimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.addPulse(target: self.fingerA, duration: 0.5)
            self.addPulse(target: self.fingerB, duration: 0.5)
        })
        
        fingerBTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.addPulse(target: self.fingerA, duration: 0.75)
            self.addPulse(target: self.fingerB, duration: 0.75)
        })
    }
    
    func stopPulse() {
        fingerATimer.invalidate()
        fingerBTimer.invalidate()
    }
    
    func addPulse(target: UIView, duration: Double) {
        let radius = target.frame.width * 2.5
        let pulse = Pulsing(numberOfPulses: 1, radius: radius/2, position: target.center)
        pulse.animationDuration = duration
        pulse.backgroundColor = UIColor.clear.cgColor
        pulse.borderWidth = 3
        pulse.borderColor = UIColor.Theme.on.cgColor
        
        twoFingerView.layer.insertSublayer(pulse, below: target.layer)
    }
    func toggle() {
        if isHidden {
            alpha = 0
            isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
            }, completion: { (success) in
               self.animateTwoFingerOn()
            
            })
            
            
        } else {
            stopPulse()
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }, completion: { (success) in
                self.isHidden = true
                self.handBaseConstraint.constant = self.handsOff
            })
        }
    }
    
    func animateTwoFingerOn() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.handBaseConstraint.constant = self.handsOn
            self.layoutIfNeeded()
        }) { (success) in
            self.initTwoFingerPulse()
        }
        
        
        
        
    }

}






/*
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // Do any additional setup after loading the view, typically from a nib.
 
 timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
 self.addPulse(target: self.finger1, duration: 0.5)
 self.addPulse(target: self.finger2, duration: 0.5)
 })
 
 timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
 self.addPulse(target: self.finger1, duration: 0.75)
 self.addPulse(target: self.finger2, duration: 0.75)
 })
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 
 }
 
 
 
 

 */
