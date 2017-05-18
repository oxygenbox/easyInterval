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
    
    
    //MARK:- LifeCycle
    override init(frame: CGRect) {
    super.init(frame: frame)
        addCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(numberOfPulses: Float = Float.infinity, radius: CGFloat, position: CGPoint) {
//        super.init()
//    }
    
    func addCircle() {
        let dim = frame.size.height/2
        let cRadius = frame.size.height/2 - lineWidth
       
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: dim, y: dim), radius: cRadius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi-CGFloat.pi/2, clockwise: true)
        
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = color.cgColor
        self.shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
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
 super.init(frame: frame)
 
 layer.cornerRadius = boundry
 layer.masksToBounds = true
 layer.borderWidth = 1
 layer.borderColor = color.withAlphaComponent(0.50).cgColor
 
 let blur = UIBlurEffect(style: .light)
 let blurView = UIVisualEffectView(effect: blur)
 blurView.frame = bounds
 addSubview(blurView)
 self.addButtons()
 self.createLabel()
 homeY = frame.origin.y
 isHidden = true
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
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
 
 func addButtons() {
 let xOffSet: CGFloat = 10
 let h: CGFloat = 40.0
 var w = frame.size.width
 w -= 30
 w /= 2
 let yOffset = frame.size.height - (h + xOffSet)
 
 for button in [firstTimerButton, secondTimerButton, doneButton] {
 button.layer.cornerRadius = h/2
 button.backgroundColor = color
 button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
 button.setTitleColor(UIColor.gray, for: .normal)
 }
 
 firstTimerButton.frame = CGRect(x: xOffSet, y: yOffset, width: w, height: h)
 firstTimerButton.setTitle("Start Timer", for: .normal)
 firstTimerButton.addTarget(self, action: #selector(startFirstTimer), for: .touchUpInside)
 addSubview(firstTimerButton)
 
 secondTimerButton.frame = CGRect(x: xOffSet * 2 + w, y: yOffset, width: w, height: h)
 secondTimerButton.setTitle("Start Rep 2", for: .normal)
 secondTimerButton.addTarget(self, action: #selector(startSecondTimer), for: .touchUpInside)
 addSubview(secondTimerButton)
 
 doneButton.frame = CGRect(x: xOffSet, y: yOffset, width: frame.size.width - (xOffSet*2), height: h)
 doneButton.setTitle("Complete", for: .normal)
 doneButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
 addSubview(doneButton)
 
 resetButton = UIButton()
 resetButton.frame = CGRect(x: frame.size.width - 45, y: 5, width: 40, height: 40)
 resetButton.layer.cornerRadius = resetButton.frame.size.height/2
 resetButton.setTitleColor(UIColor.white, for:.normal)
 resetButton.setTitle("⟲", for: .normal)
 resetButton.layer.borderColor = UIColor.white.cgColor
 resetButton.layer.borderWidth = 1
 resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
 //addSubview(resetButton)
 }
 
 func createLabel() {
 let h: CGFloat = 70
 let w = frame.size.width
 let y  = frame.height/2 - h/2
 self.label = UILabel(frame: CGRect(x: 0, y: y-20, width: w, height: h))
 self.label.font = UIFont(name: "AvenirNext-Bold", size: h)
 self.label.textAlignment = .center
 self.label.textColor = color
 self.label.text = "60"
 self.addSubview(self.label)
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
 
 func updateLabel(value: Int) {
 self.setLabelText(value: self.timeFormatted(totalSeconds: value))
 self.addCircle()
 }
 
 func setLabelText(value: String) {
 self.label.text = value
 }
 
 func timeFormatted(totalSeconds: Int) -> String {
 return "\(totalSeconds)"
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




