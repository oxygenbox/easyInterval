//
//  ModeView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/14/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import UIKit

class ModeView: UIView {
    //MARK:- CONSTANTS
    let headTimerLayer = CAShapeLayer()
    let backLayer = CAShapeLayer()
    let bodyLayer = CAShapeLayer()
    let headLayer = CAShapeLayer()
    
    
    var mode: Mode = .run {
        didSet {
            setModePath()
        }
    }

    
    
    //MARK:- LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
        
    }
    
    func setUp(){
        //makeHeadTimer()
        backLayer.strokeColor = UIColor.cyan.cgColor
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.lineWidth = 2.0
        backLayer.lineCap = kCALineCapRound
        backLayer.path = Paths.walkingBody.cgPath
        
        
        bodyLayer.strokeColor = UIColor.black.cgColor
        bodyLayer.fillColor = UIColor.clear.cgColor
        bodyLayer.lineWidth = 2.0
        bodyLayer.lineCap = kCALineCapRound
        bodyLayer.path = Paths.walkingBody.cgPath
        
        headLayer.strokeColor = UIColor.black.cgColor
        headLayer.fillColor = UIColor.clear.cgColor
        headLayer.lineWidth = 2.0
        headLayer.lineCap = kCALineCapRound
        headLayer.path = Paths.walkingHead.cgPath
        
        //add layers
        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(bodyLayer)
        self.layer.addSublayer(headLayer)
        setModePath()
        updateAnimation()
    }
    
    func updateAnimation() {
        
    }
    
    func setModePath() {
        if mode == .run {
            bodyLayer.path = Paths.runningBody.cgPath
            backLayer.path = Paths.runningBody.cgPath
            headLayer.path = Paths.runningHead.cgPath
        }else {
            bodyLayer.path = Paths.walkingBody.cgPath
            backLayer.path = Paths.walkingBody.cgPath
            headLayer.path = Paths.walkingHead.cgPath
        }

    }
}



/*
 class ModeIconView: UIView {
 var timer: Timer!
 var total:CGFloat = 60
 var tick:CGFloat = 0
 var isRunning = false
 
 
 
 func setUp() {
 
 
 
 
 }
 
 @IBAction func switchMode() {
 isRunning = !isRunning
 
 if isRunning {
 bodyLayer.path = Paths.runningBody.cgPath
 backLayer.path = Paths.runningBody.cgPath
 headLayer.path = Paths.runningHead.cgPath
 }else {
 bodyLayer.path = Paths.walkingBody.cgPath
 backLayer.path = Paths.walkingBody.cgPath
 headLayer.path = Paths.walkingHead.cgPath
 }
 makeHeadTimer()
 }
 
 @IBAction func toggleAnimation(sender: UIButton) {
 animating = !animating
 
 if animating {
 resumeAnimation(layer: bodyLayer)
 } else {
 pauseAnimation(layer: bodyLayer)
 }
 
 }
 
 func  updateAnimation() {
 if  animating {
 bodyLayer.add(strokeEndAnimation, forKey: "strokeEnd")
 bodyLayer.add(strokeStartAnimation, forKey: "strokeStart")
 } else {
 bodyLayer.removeAnimation(forKey: "strokeEnd")
 bodyLayer.add(strokeEndAnimation, forKey: "strokeStart")
 }
 
 }
 
 let strokeEndAnimation: CAAnimation = {
 let animation = CABasicAnimation(keyPath: "strokeEnd")
 animation.fromValue = 0
 animation.toValue = 1
 animation.duration = 5.5
 animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
 let group = CAAnimationGroup()
 group.duration = 5.5
 group.repeatCount = MAXFLOAT
 group.animations = [animation]
 return group
 }()
 
 
 let strokeStartAnimation : CAAnimation = {
 let animation = CABasicAnimation(keyPath: "strokeStart")
 animation.beginTime = 0.75
 animation.fromValue = 0
 animation.toValue = 1
 animation.duration = 5.5
 animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
 let group = CAAnimationGroup()
 group.duration = 5.5
 group.repeatCount = MAXFLOAT
 group.animations = [animation]
 
 return group
 }()
 
 let rotateAnimation: CABasicAnimation = {
 let animation = CABasicAnimation(keyPath: "transfor,transform.rotation.z")
 animation.fromValue = 0
 animation.toValue = 1 //M_PI * 2
 animation.duration = 2
 animation.repeatCount = MAXFLOAT
 return animation
 
 }()
 
 @IBInspectable var animating: Bool = true {
 didSet {
 updateAnimation()
 }
 }
 
 
 func makeHeadTimer() {
 
 let circleLayer = CAShapeLayer()
 
 var rect = Paths.walkingHead.bounds
 if isRunning {
 rect = Paths.runningHead.bounds
 
 }
 
 let center = CGPoint(x:rect.midX, y: rect.midY)
 let radius = min(rect.width, rect.height) / 2-circleLayer.lineWidth/2
 
 let startAngle = CGFloat(-M_PI_2)
 let endAngle = startAngle + CGFloat(M_PI * 2)
 let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
 
 headTimerLayer.position = center
 headTimerLayer.path = path.cgPath
 headTimerLayer.fillColor = UIColor.cyan.cgColor
 headTimerLayer.strokeColor = UIColor.orange.cgColor
 headTimerLayer.lineWidth = radius
 layer.addSublayer(headTimerLayer)
 
 
 let animation = CABasicAnimation(keyPath: "strokeEnd")
 
 animation.fromValue = 0.0
 animation.toValue = 1.0
 animation.duration = 30.0
 
 headTimerLayer.add(animation, forKey: "dawLineAnimation")
 
 }
 
 func pauseAnimation(layer: CAShapeLayer){
 let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
 layer.speed = 0.0
 layer.timeOffset = pausedTime
 }
 
 func resumeAnimation(layer: CAShapeLayer){
 let pausedTime = layer.timeOffset
 layer.speed = 1.0
 layer.timeOffset = 0.0
 layer.beginTime = 0.0
 let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
 layer.beginTime = timeSincePause
 }
 
 
 
 }
 
 
 
 
 
 

 
 */
