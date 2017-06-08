//
//  RingsView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/27/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RingsView: UIView {
    
    //MARK:- VARIABLES
    var baseRing: CAShapeLayer!
    var  intervalRing: CAShapeLayer!
    var elapsedRing: CAShapeLayer!
    
    //MARK:- LIFECYCLE
    override func layoutSubviews() {
        configure()
    }
    
    //MARK:- METHODS
    func configure() {
        intervalRing = makeCircle(fill: .clear, stroke: .blueC, lineWidth: bounds.width/2, end: 0.0, clockwise: true)
       // baseRing = makeCircle(fill: .clear, stroke: .blueD, lineWidth: 4, end: 1, clockwise: true)
        elapsedRing = makeCircle(fill: .clear, stroke: .red, lineWidth: 4, end: 1.0, clockwise: true)
        
        layer.insertSublayer(elapsedRing, at: 0)
        layer.insertSublayer(baseRing, at: 0)
        layer.insertSublayer(intervalRing, at: 0)
    }
    
    func makeCircle(fill: UIColor, stroke: UIColor, lineWidth: CGFloat, end: CGFloat, clockwise: Bool) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = fill.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = end
        
        //let startAngle = CGFloat(-M_PI_2)
        let startAngle = -(CGFloat.pi/2)
        let endAngle = startAngle + (CGFloat.pi * 2)
        //let endAngle = startAngle + CGFloat(M_PI * 2)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - (shapeLayer.lineWidth / 2)
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        shapeLayer.position = center
        shapeLayer.path = path.cgPath
        shapeLayer.strokeEnd = end
        
        return shapeLayer
    }
    
    func intervalTimer(percent: CGFloat) {
         animateTick(layer: intervalRing, pct: percent)
    }
    
    func animateTick(layer: CAShapeLayer, pct: CGFloat) {
          layer.removeAllAnimations()
          layer.strokeEnd = pct
    }
    
    func elapsedTimer(percent: CGFloat) {
        animateTick(layer: elapsedRing, pct: percent)
    }
}


