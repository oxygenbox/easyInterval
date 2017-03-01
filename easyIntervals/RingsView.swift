//
//  RingsView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/27/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RingsView: UIView {
    var baseRing: CAShapeLayer!
    var timerRing: CAShapeLayer!
    var elapsedRing: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
        //configure()
    }
    
    override func layoutSubviews() {
        configure()
    }
    
    func configure() {
        baseRing = makeCircle(fill: .clear, stroke: .lightGray, lineWidth: 8, clockwise: true, end:  1)
        let timerWidth = bounds.width / 2
        timerRing = makeCircle(fill: .clear, stroke: .blueD, lineWidth: timerWidth, clockwise: true, end: 0)
        elapsedRing = makeCircle(fill: .clear, stroke: .darkGray, lineWidth: 4, clockwise: true, end: 0.25)
        
      //  layer.addSublayer(timerRing)
      //  layer.addSublayer(baseRing)
      //  layer.addSublayer(elapsedRing)
        layer.insertSublayer(elapsedRing, at: 0)
        layer.insertSublayer(baseRing, at: 0)
        layer.insertSublayer(timerRing, at: 0)
 
    }
    
    func makeCircle(fill: UIColor, stroke: UIColor, lineWidth: CGFloat, clockwise: Bool, end: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = fill.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth  = lineWidth
        shapeLayer.strokeEnd = end
        
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - shapeLayer.lineWidth/2
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        shapeLayer.position = center
        shapeLayer.path = path.cgPath
        
        return shapeLayer
    }
    
    func elapsedTimer(percent: CGFloat) {
        animateTick(layer: elapsedRing, pct: percent)
    }
    
    func intervalTimer(percent: CGFloat) {
        animateTick(layer: timerRing, pct: percent)
        print(percent)
    }

    func animateTick(layer: CAShapeLayer, pct: CGFloat) {
        layer.removeAllAnimations()
        layer.strokeEnd = pct
    }
    
   
}


