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
    //let elapsedLayer = CAShapeLayer()
    
    let lineWidth:CGFloat = 4.0
    
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
    
    //MARK:- VARIABLES
    var mode: Mode = .run {
        didSet {
            setModePath()
            setHeadTimer()
        }
    }

    var animating: Bool = true {
        didSet {
            updateAnimation()
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
    
    //MARK:- METHODS
    func setUp(){
        backgroundColor = UIColor.white
        //makeHeadTimer()
        backLayer.strokeColor = UIColor.blueC.cgColor
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.lineWidth = lineWidth
        backLayer.lineCap = kCALineCapRound
        backLayer.path = Paths.walkingBody.cgPath
        
        
        bodyLayer.strokeColor = UIColor.accent.cgColor
        bodyLayer.fillColor = UIColor.clear.cgColor
        bodyLayer.lineWidth = lineWidth
        bodyLayer.lineCap = kCALineCapRound
        bodyLayer.path = Paths.walkingBody.cgPath
        
        headLayer.strokeColor = UIColor.blueC.cgColor
        headLayer.fillColor = UIColor.clear.cgColor
        headLayer.lineWidth = lineWidth
        headLayer.lineCap = kCALineCapRound
        headLayer.path = Paths.walkingHead.cgPath
        headLayer.fillColor = UIColor.clear.cgColor
        
        /*
        elapsedLayer.strokeColor = UIColor.accent.cgColor
        elapsedLayer.strokeEnd = 0.3
        elapsedLayer.fillColor = UIColor.clear.cgColor
        elapsedLayer.lineWidth = lineWidth
        elapsedLayer.lineCap = kCALineCapRound
        elapsedLayer.path = Paths.walkingHead.cgPath
        elapsedLayer.fillColor = UIColor.clear.cgColor
        */
        
        //add layers
        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(bodyLayer)
        self.layer.addSublayer(headLayer)
        //self.layer.addSublayer(elapsedLayer)
        setModePath()
        updateAnimation()
        pauseAnimation(layer: bodyLayer)
    }
    
    func updateAnimation() {
        if  animating {
            bodyLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            bodyLayer.add(strokeStartAnimation, forKey: "strokeStart")
            //headLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            //headLayer.add(strokeStartAnimation, forKey: "strokeStart")
 
        } else {
            bodyLayer.removeAnimation(forKey: "strokeEnd")
            bodyLayer.add(strokeEndAnimation, forKey: "strokeStart")
            headLayer.removeAnimation(forKey: "strokeEnd")
            headLayer.add(strokeEndAnimation, forKey: "strokeStart")
        }
    }
    
    func setModePath() {
        if mode == .run {
            bodyLayer.path = Paths.runningBody.cgPath
            backLayer.path = Paths.runningBody.cgPath
            headLayer.path = Paths.runningHead.cgPath
          //  elapsedLayer.path = Paths.runningHead.cgPath
        }else {
            bodyLayer.path = Paths.walkingBody.cgPath
            backLayer.path = Paths.walkingBody.cgPath
            headLayer.path = Paths.walkingHead.cgPath
          //  elapsedLayer.path = Paths.walkingHead.cgPath
        }
        
        // setHeadTimer()
        // makeHeadTimer()
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
    
    func pause() {
        pauseAnimation(layer: bodyLayer)
    }
    
    func play() {
        resumeAnimation(layer: bodyLayer)
    }
    
    func setHeadTimer() {
        
        let circleLayer = CAShapeLayer()
        
        var rect = Paths.walkingHead.bounds
        if mode == .run {
            rect = Paths.runningHead.bounds
        }
        
        let center = CGPoint(x:rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2-circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        headTimerLayer.position = center
        headTimerLayer.path = path.cgPath
        headTimerLayer.fillColor = UIColor.clear.cgColor
        headTimerLayer.strokeColor = UIColor.blueC.cgColor
        headTimerLayer.lineWidth = radius
        headTimerLayer.strokeEnd = 0
        layer.addSublayer(headTimerLayer)
    
        //let animation = CABasicAnimation(keyPath: "strokeEnd")
        //animation.fromValue = 0.0
        //animation.toValue = 0.5
        //animation.duration = 30.0
       // headTimerLayer.add(animation, forKey: "dawLineAnimation")
    }
    
    func animateStroke(layer: CAShapeLayer, pct: CGFloat) {
        layer.removeAllAnimations()
        layer.strokeEnd = pct
    }
    
    func animateHead(pct: CGFloat) {
        animateStroke(layer: headTimerLayer, pct: pct)
    }
    
    
}





 
 

