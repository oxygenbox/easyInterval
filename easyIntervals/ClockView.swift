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
    var color = UIColor.black
    var homeY: CGFloat = 0
    
    
    //MARK:- LifeCycle
    
    override init(frame: CGRect) {
    super.init(frame: frame)
        addCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCircle() {
        let h = frame.size.height/2 
        let cRadius = frame.size.height/2
       
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: h, y: cRadius), radius: cRadius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi-CGFloat.pi/2, clockwise: true)
        
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


