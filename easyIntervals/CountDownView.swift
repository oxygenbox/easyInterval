//
//  CountDownView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/19/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class CountDownView: UIView {
    @IBOutlet var dots: [CountDownDot]!
    
    var sequenceTracker  = true
    
    let timer = Timer()
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.clear
        for (index, dot) in dots.enumerated() {
            dot.configure(tagNum: dots.count - index)
        }
    }
    
    func countDown(second: Int) {
        let dot = dots[dots.count - second]
        dot.animateOn()
    }
    
    func startSequence() {
        
    }
    
    
    var stopSequence() {
    
    }
    
    
    func sequence() {
        
        if sequenceTracker {
            dots[0].alpha = 1
            dots[1].alpha = 0
            dots[2].alpha = 0
            dots[3].alpha = 0
            dots[4].alpha = 1
        } else {
            dots[0].alpha = 0
            dots[1].alpha = 1
            dots[2].alpha = 0
            dots[3].alpha = 1
            dots[4].alpha = 0
        }
        
        sequenceTracker = !sequenceTracker
    }

}
