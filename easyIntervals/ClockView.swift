//
//  ClockView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//



import Foundation
import UIKit

protocol ClockViewDelegate {
    func complete()
}

class ClockView: UIView {
    //MARK:- variables
    
    let lineWidth: CGFloat = 6
    
    var shapeLayer = CAShapeLayer()
    var countDownTimer = Timer()
    var timerValue = 0
    var ticks = 0
    var label = UILabel()
    var firstTimerButton = UIButton()
    var secondTimerButton = UIButton()
    var doneButton: UIButton = UIButton()
    var resetButton: UIButton = UIButton()
    var delegate: ClockViewDelegate?
    var color = UIColor.gray
    var homeY: CGFloat = 0
    
    var hasStarted:Bool {
        return self.layer.timeOffset > 0
    }
    
    //MARK:- LifeCycle
    override init(frame: CGRect) {
    super.init(frame: frame)
        addCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCircle() {
        let dim = frame.size.height/2
        let cRadius = frame.size.height/2 - lineWidth
       
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: dim, y: dim), radius: cRadius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi-CGFloat.pi/2, clockwise: true)
        
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = color.cgColor
        self.shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(self.timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        self.shapeLayer.add(animation, forKey: "ani")
    }
 
    func completeTapped() {
        if let d = delegate {
            d.complete()
        }
    }
    
    
    func skip() {
        shapeLayer.removeAllAnimations()
    }
    
    
    func pause() {
        let  pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resume() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    func begin(with seconds: Int) {
        timerValue = seconds
        ticks = seconds
        startAnimation()
    }
    
    func  reset() {
        shapeLayer.timeOffset = 0
    }
    
    
    
}


/*
 //
 //  ClockView.swift
 //  CircuitSelector
 //
 //  Created by Michael Schaffner on 4/25/17.
 //  Copyright © 2017 Michael Schaffner. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 protocol ClockViewDelegate {
 func complete()
 }
 
 class ClockView: UIView {
 //MARK:- variables
 let boundry: CGFloat  = 10
 let offset: CGFloat = 40
 let margin: CGFloat = 8
 let buttonHeight: CGFloat = 40
 
 var shapeLayer = CAShapeLayer()
 var countDownTimer = Timer()
 var timerValue = 900
 var ticks = 0
 var label = UILabel()
 var firstTimerButton = UIButton()
 var secondTimerButton = UIButton()
 var doneButton: UIButton = UIButton()
 var resetButton: UIButton = UIButton()
 var delegate: ClockViewDelegate?
 var color = UIColor.white
 var homeY: CGFloat = 0
 
 
 //MARK:- LifeCycle
 
 override init(frame: CGRect) {
 
 
 
 func addCircle() {
 let h = frame.size.height/2
 var cRadius = frame.size.height - (margin * 2)
 cRadius -= buttonHeight + margin
 cRadius /= 2
 
 let circlePath = UIBezierPath(arcCenter: CGPoint(x: h, y: margin + cRadius), radius: cRadius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi-CGFloat.pi/2, clockwise: true)
 
 self.shapeLayer.path = circlePath.cgPath
 self.shapeLayer.fillColor = UIColor.clear.cgColor
 self.shapeLayer.strokeColor = color.cgColor
 self.shapeLayer.lineWidth = 4.0
 self.layer.addSublayer(shapeLayer)
 }
 
 
 

 
 func updateLabel(value: Int) {
 self.setLabelText(value: self.timeFormatted(totalSeconds: value))
 self.addCircle()
 }
 
 
 func countDown() {
 self.timerValue -= 1
 if timerValue < 0 {
 timerComplete()
 } else {
 self.setLabelText(value: self.timeFormatted(totalSeconds: self.timerValue))
 }
 }
 
 func setTimer(value: Int) {
 self.timerValue = value
 self.ticks = value
 self.updateLabel(value: value)
 }
 
 func setButtons(value: Int) {
 doneButton.isHidden = true
 firstTimerButton.isEnabled = true
 firstTimerButton.alpha = 1
 firstTimerButton.setTitle("Start Timer", for: .normal)
 if value > 0 {
 secondTimerButton.isHidden = false
 firstTimerButton.setTitle("Start Rep 1", for: .normal)
 } else {
 secondTimerButton.isEnabled = false
 secondTimerButton.alpha = 1
 secondTimerButton.isHidden = true
 }
 }
 
 func startCountDown() {
 self.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
 self.countDown()
 })
 self.startAnimation()
 }
 
 func startFirstTimer() {
 self.startCountDown()
 firstTimerButton.isEnabled = false
 firstTimerButton.alpha = 0.7
 }
 
 func startSecondTimer () {
 secondTimerButton.alpha = 0.7
 print("Second Tapped")
 self.timerValue = ticks
 self.setTimer(value: self.timerValue)
 self.startCountDown()
 }
 
 func completeTapped() {
 if let d = delegate {
 d.complete()
 }
 }
 
 func resetTapped() {
 if doneButton.isHidden {
 // self.timerValue =
 }
 }
 
 func timerComplete() {
 self.countDownTimer.invalidate()
 if secondTimerButton.isHidden {
 self.doneButton.isHidden = false
 } else {
 if secondTimerButton.alpha == 1 {
 self.secondTimerButton.isEnabled = true
 } else {
 self.doneButton.isHidden = false
 }
 }
 }
 
 func skip() {
 countDownTimer.invalidate()
 shapeLayer.removeAllAnimations()
 }
 
 
 }
 
 
 
 
 
 
 
 
 
 

 */




